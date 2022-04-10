//
//  ForecastView.swift
//  WeatherDemo
//
//  Created by Jérôme Figueiredo on 09/04/2022.
//

import SwiftUI

struct ForecastView: View {
    // MARK: - Properties
    @ObservedObject var viewModel: WeatherViewModel
        
    // MARK: - Body
    var body: some View {
        HStack(spacing: 0) {
            ForecastDayView(weatherColor: $viewModel.day1Color,
                         icon: $viewModel.day1Icon,
                         dayName: $viewModel.day1name,
                         maxTemp: $viewModel.day1MaxTemp,
                         minTemp: $viewModel.day1MinTemp)
            
            ForecastDayView(weatherColor: $viewModel.day2Color,
                         icon: $viewModel.day2Icon,
                         dayName: $viewModel.day2name,
                         maxTemp: $viewModel.day2MaxTemp,
                         minTemp: $viewModel.day2MinTemp)
            
            ForecastDayView(weatherColor: $viewModel.day3Color,
                         icon: $viewModel.day3Icon,
                         dayName: $viewModel.day3name,
                         maxTemp: $viewModel.day3MaxTemp,
                         minTemp: $viewModel.day3MinTemp)
            
            ForecastDayView(weatherColor: $viewModel.day4Color,
                         icon: $viewModel.day4Icon,
                         dayName: $viewModel.day4name,
                         maxTemp: $viewModel.day4MaxTemp,
                         minTemp: $viewModel.day4MinTemp)
        }
        .padding(.bottom)
    }
}

// MARK: - Preview
struct ForecastView_Previews: PreviewProvider {
    static var previews: some View {
        ForecastView(viewModel: WeatherViewModel())
            .previewLayout(.sizeThatFits)
    }
}
