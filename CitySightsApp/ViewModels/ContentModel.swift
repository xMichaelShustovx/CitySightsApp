//
//  ContentModel.swift
//  CitySightsApp
//
//  Created by Michael Shustov on 31.07.2021.
//

import Foundation
import CoreLocation

class ContenModel: NSObject, CLLocationManagerDelegate, ObservableObject {
    
    let locationManager = CLLocationManager()
    
    @Published var restaurants = [Business]()
    @Published var sights = [Business]()
    
    override init() {
        
        super.init()
        
        // Set ContentModel as the delegate of the location manager
        locationManager.delegate = self
        
        // Request permission
        locationManager.requestWhenInUseAuthorization()
        
    }
    
    // MARK: - Location manager delegate methods
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        if locationManager.authorizationStatus == .authorizedAlways ||
            locationManager.authorizationStatus == .authorizedWhenInUse {
            
            // Start geolocating
            
            locationManager.startUpdatingLocation()
            
        }
        else if locationManager.authorizationStatus == .denied {
            
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // Gives us the location of the user
        
        let userLocation = locations.first
        
        if userLocation != nil {
            
            // Stop requesting the location after we get it once
            
            locationManager.stopUpdatingLocation()
            
            // If we have the coordinates of the user, send into YelpAPI
            
            getBusinesses(category: Constants.sightsKey, location: userLocation!)
            
            getBusinesses(category: Constants.restaurantsKey, location: userLocation!)
            
        }
    }
    
    // MARK: - Yelp API methods
    
    func getBusinesses(category:String, location:CLLocation) {
        
        // Create URL
        // One way of crafting url string for API
        /*
         let urlString = "https://api.yelp.com/v3/businesses/search?latitude=\(location.coordinate.latitude)&longtitude=\(location.coordinate.longitude)&categories=\(category)&limit=6"
         
         let url = URL(string: urlString)
         */
        
        // Another way
        
        var urlComponents = URLComponents(string: Constants.apiUrl)
        
        urlComponents?.queryItems = [
            
            URLQueryItem(name: "latitude", value: String(location.coordinate.latitude)),
            URLQueryItem(name: "longitude", value: String(location.coordinate.longitude)),
            URLQueryItem(name: "categories", value: String(category)),
            URLQueryItem(name: "limit", value: "6")
            
        ]
        
        let url = urlComponents?.url
        
        if let url = url {
            
            // Create URL request
            
            var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10.0)
            
            request.httpMethod = "GET"
            
            request.addValue("Bearer \(Constants.apiKey)", forHTTPHeaderField: "Authorization")
            
            // Get URL session
            
            let session = URLSession.shared
            
            // Create Data Task
            
            let dataTask = session.dataTask(with: request) { (data, response, error) in
                
                if error == nil {
                    
                    do {
                        
                        // Parse json
                        let decoder = JSONDecoder()
                        
                        let result = try decoder.decode(BusinessSearch.self, from: data!)
                        
                        DispatchQueue.main.async {
                            
                            switch category {
                            case Constants.sightsKey:
                                self.sights = result.businesses
                            case Constants.restaurantsKey:
                                self.restaurants = result.businesses
                            default:
                                break
                            }   
                        }
                    }
                    catch {
                        
                        print(error)
                        
                    }
                }
            }
            
            // Start Data Task
            dataTask.resume()
            
        }
    }
}
