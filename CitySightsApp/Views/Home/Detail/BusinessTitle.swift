//
//  BusinessTitle.swift
//  CitySightsApp
//
//  Created by Michael Shustov on 05.08.2021.
//

import SwiftUI

struct BusinessTitle: View {
    
    var business: Business
    
    var body: some View {
        
        
        VStack (alignment: .leading) {
            // Business name
            Text(business.name!)
                .font(.largeTitle)
            
            // Address
            if business.location?.displayAddress != nil {
                
                ForEach(business.location!.displayAddress!, id: \.self) { displayLine in
                    Text(displayLine)
                }
            }
            
            // Rating
            Image("regular_\(business.rating ?? 0.0)")
        }
    }
}
