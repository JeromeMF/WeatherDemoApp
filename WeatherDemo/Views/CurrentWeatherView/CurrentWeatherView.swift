//
//  CurrentWeatherView.swift
//  WeatherDemo
//
//  Created by Jérôme Figueiredo on 06/04/2022.
//

import SwiftUI

struct CurrentWeatherView: View {
    // MARK: - Properties
    @ObservedObject var viewModel: CurrentWeatherViewModel = CurrentWeatherViewModel()
    
    var body: some View {
        Button(action: {
            viewModel.getGeoInfo()
        },label: {
            Text("Get Coordinates for Lisbon")
        })
    }
}

struct CurrentWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentWeatherView()
    }
}
