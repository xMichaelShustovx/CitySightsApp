//
//  HomeView.swift
//  CitySightsApp
//
//  Created by Michael Shustov on 03.08.2021.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var model: ContentModel
    @State var isMapShowing = false
    
    var body: some View {
        
        if model.restaurants.count != 0 || model.sights.count != 0 {
            
            NavigationView {
                
                if !isMapShowing {
                    
                    VStack(alignment: .leading) {
                        
                        HStack {
                            
                            Image(systemName: "location")
                            Text("Lytkarino")
                            Spacer()
                            Text("Switch to map view")
                            
                        }
                        
                        Divider()
                        
                        BusinessList()
                        
                    }
                    .padding([.horizontal, .top])
                    .navigationBarHidden(true)
                    
                }
                else {
                    
                    // Show map
                    
                }
            }
        }
        else {
            ProgressView()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
