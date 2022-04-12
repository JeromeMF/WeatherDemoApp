//
//  InitialView.swift
//  WeatherDemo
//
//  Created by Jérôme Figueiredo on 09/04/2022.
//

import SwiftUI

struct InitialView: View {
    // MARK: - Properties
    @StateObject var locationViewModel = LocationViewModel()
    
    // MARK: - Body
    var body: some View {
        ZStack() {
            VStack {
                Spacer()
                Image("landscape1")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.black.opacity(0.03))
            }
            
            switch locationViewModel.authorizationStatus {
            case .notDetermined:
                AnyView(RequestLocationView())
                    .environmentObject(locationViewModel)
            case .restricted:
                ErrorView(errorText: "Location use is restricted.")
            case .denied:
                ErrorView(errorText: "The app does not have location permissions. Please enable them in settings if you want accurate data. \nDefault location used: Lisbon")
            case .authorizedAlways, .authorizedWhenInUse:
                WeatherView()
                    .environmentObject(locationViewModel)
            default:
                Text("Unexpected status")
            }
        }
    }
}

// MARK: - Preview
struct InitialView_Previews: PreviewProvider {
    static var previews: some View {
        InitialView()
    }
}
