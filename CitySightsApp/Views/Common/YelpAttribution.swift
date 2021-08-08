//
//  YelpAttribution.swift
//  CitySightsApp
//
//  Created by Michael Shustov on 08.08.2021.
//

import SwiftUI

struct YelpAttribution: View {
    
    var link: String
    
    var body: some View {
        
        Link(destination: URL(string: link)!) {
            
            Image("yelp")
                .resizable()
                .scaledToFit()
                .frame(height: 36)
            
        }
        
    }
}
