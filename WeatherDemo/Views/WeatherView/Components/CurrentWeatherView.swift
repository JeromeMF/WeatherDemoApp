//
//  CurrentWeatherView.swift
//  WeatherDemo
//
//  Created by Jérôme Figueiredo on 10/04/2022.
//

import SwiftUI

struct CurrentWeatherView: View {
    // MARK: - Properties
    @ObservedObject var viewModel: WeatherViewModel
    
    // MARK: - Body
    var body: some View {
        VStack() {
            ZStack(alignment: .center) {
                HStack(alignment: .center) {
                    Spacer()
                    Text("\(viewModel.currentTemperature)")
                        .font(.system(size: 100))
                        .foregroundColor(viewModel.fontColor)                                .edgesIgnoringSafeArea(.all)
                    
                    VStack(alignment:.leading) {
                        Text("°C")
                            .font(.headingL)
                            .foregroundColor(viewModel.fontColor)
                        HStack {
                            Image(systemName: "arrow.up")
                            Text("\(viewModel.maxTemp)")
                        }
                        .font(.headingM)
                        .foregroundColor(viewModel.fontColor)
                        HStack {
                            Image(systemName: "arrow.down")
                            Text("\(viewModel.minTemp)")
                            
                        }
                        .font(.headingM)
                        .foregroundColor(viewModel.fontColor)
                    }//: VStack
                    Spacer()
                }//: HStack
            }//: ZStack center
            
            viewModel.weatherIcon //: Icon
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 150)
                .foregroundColor(viewModel.fontColor)
                .padding()
            
            Text(viewModel.weatherDescription)
                .font(.headingL)
                .foregroundColor(viewModel.fontColor)
        }
    }
}

// MARK: - Preview
struct CurrentWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentWeatherView(viewModel: WeatherViewModel())
            .previewLayout(.sizeThatFits)
            .background(Color.black)
            .padding()
    }
}
