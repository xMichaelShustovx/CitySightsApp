//
//  BusinessSearch.swift
//  CitySightsApp
//
//  Created by Michael Shustov on 03.08.2021.
//

import Foundation


class BusinessSearch: Decodable {
    
    var businesses = [Business]()
    
    var total = 0
    
    var region = Region()
    
}

struct Region: Decodable {
    var center = Coordinate()
}
