//
//  LaunchView.swift
//  CitySightsApp
//
//  Created by Michael Shustov on 31.07.2021.
//

import SwiftUI
import CoreLocation

struct LaunchView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        
        // Detect the authorization status of the user
        if model.authorizationState == .notDetermined {
            
            // If undetermined, show onboarding
            OnboardingView()
            
        }
        else if model.authorizationState == .authorizedAlways || model.authorizationState == .authorizedWhenInUse {
            
            // If approved, show home view
            HomeView()
            
        }
        else {
            
            // If denied, show denied view
            LocationDeniedView()
            
        }
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
    }
}
