//
//  CitySightsApp.swift
//  CitySightsApp
//
//  Created by Michael Shustov on 31.07.2021.
//

import SwiftUI

@main
struct CitySightsApp: App {
    var body: some Scene {
        WindowGroup {
            LaunchView()
                .environmentObject(ContenModel())
        }
    }
}
