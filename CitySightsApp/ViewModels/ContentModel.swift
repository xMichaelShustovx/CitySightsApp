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
            
            //getBusinesses(category: "arts", location: userLocation!)
            
            getBusinesses(category: "restaurants", location: userLocation!)
            
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
        
        var urlComponents = URLComponents(string: "https://api.yelp.com/v3/businesses/search")
        
        urlComponents?.queryItems = [
            
            URLQueryItem(name: "latitude", value: String(location.coordinate.latitude)),
            URLQueryItem(name: "longtitude", value: String(location.coordinate.longitude)),
            URLQueryItem(name: "categories", value: String(category)),
            URLQueryItem(name: "limit", value: "6")
            
        ]
        
        let url = urlComponents?.url
        
        if let url = url {
        
            // Create URL request
            
            var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10.0)
            
            request.httpMethod = "GET"
            
            request.addValue("Bearer Get your OWN API key", forHTTPHeaderField: "Authorization")
            
            // Get URL session
            
            let session = URLSession.shared
            
            // Create Data Task
            
            let dataTask = session.dataTask(with: request) { (data, response, error) in
                
                if error == nil {
                    
                    print(response)
                    
                }
                
                
                
            }
            
            // Start Data Task
            dataTask.resume()
            
        }
        
    }
    
}
