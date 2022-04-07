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
    
    // MARK: - Body
    var body: some View {
        VStack() {
            Text("Temperature \(viewModel.currentTemperature) C")
            Spacer()
            Text("Day 1: \(viewModel.day1ForecastTemp) / \(viewModel.day1ForecastMinTemp)")
            Text("Day 2: \(viewModel.day2ForecastTemp) / \(viewModel.day2ForecastMinTemp)")
            Text("Day 3: \(viewModel.day3ForecastTemp) / \(viewModel.day3ForecastMinTemp)")
            Text("Day 4: \(viewModel.day4ForecastTemp) / \(viewModel.day4ForecastMinTemp)")
        Button(action: {
            viewModel.getWeatherForLocation("London")
        },label: {
            Text("Get Coordinates for London")
        })
        
        Button(action: {
            viewModel.getForecastForLocation("London")
        },label: {
            Text("Get Forecast for London")
        })
        }
        .onAppear() {
            print("YEAH")
            viewModel.getWeatherForLocation("London")
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                viewModel.getForecastForLocation("London")
            }
//            viewModel.getForecastForLocation("London")
        }
    }
}

// MARK: - Preview
struct CurrentWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentWeatherView()
    }
}
