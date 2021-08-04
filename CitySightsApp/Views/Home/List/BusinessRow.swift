//
//  BusinessRow.swift
//  CitySightsApp
//
//  Created by Michael Shustov on 04.08.2021.
//

import SwiftUI

struct BusinessRow: View {
    
    @ObservedObject var business: Business
    
    var body: some View {

        VStack(alignment: .leading) {
            
            HStack {
                // Image
                let uiImage = UIImage(data: business.imageData ?? Data())
                
                Image(uiImage: uiImage ?? UIImage())
                    .resizable()
                    .frame(width: 58, height: 58)
                    .cornerRadius(5)
                    .scaledToFit()
                
                // Name and distance
                VStack(alignment: .leading) {
                    Text(business.name ?? "")
                        .bold()
                    Text(String(format: "%.2f km away", (business.distance ?? 0)/1000))
                        .font(.caption)
                    
                }
                
                Spacer()
                
                //Star rating and number of reviews
                VStack {
                    Image("regular_\(business.rating ?? 0.0)")
                    Text("\(business.reviewCount ?? 0) Reviews")
                        .font(.caption)
                }
            }
            
            Divider()
        }
        
    }
}
