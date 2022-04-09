//
//  WeatherView.swift
//  WeatherDemo
//
//  Created by Jérôme Figueiredo on 06/04/2022.
//

import SwiftUI

struct WeatherView: View {
    // MARK: - Properties
    @ObservedObject var viewModel: WeatherViewModel = WeatherViewModel()
    //    @EnvironmentObject var locationViewModel: LocationViewModel
    
    // MARK: - Body
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                Image("landscape1")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                .foregroundColor(.black.opacity(0.03))
            }
            
            VStack(alignment: .center, spacing: 0) {
                HStack(alignment: .top, spacing: 0) {
                    Text("\(viewModel.currentLocation), ")
                        .font(.headingL)
                        .padding(.leading, 24)
                    Text(viewModel.countryCode)
                        .font(.headingM)
                    Spacer()
                    
                    Text(viewModel.currentDayName)
                        .font(.headingL)
                        .padding(.trailing, 24)
                } //: HStack Header
                .foregroundColor(.white)
                
                HStack() {
                    VStack(alignment: .leading, spacing: 20) {
                        HStack {
                            Image("cloud")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                            .frame(width: 20)
                            
                            Text("\(viewModel.cloudCoverage) %")
                                .font(.subtitleS)
                        }
                        HStack {
                            Image("wind")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                            .frame(width: 20)
                            
                            Text(String(format: "%.1f", viewModel.windSpeed) + "m/s")
                                .font(.subtitleS)
                        }
                        HStack {
                            Image("humidity")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                            .frame(width: 20)
                            
                            Text("\(viewModel.humidity) %").font(.subtitleS)
                        }
                    }
                    .foregroundColor(.white)
                    Spacer()
                }//: HStack Conditions
                .padding(.leading, 24)
                .padding(.top, 40)
                .padding(.bottom)
                
//                Spacer()
                
                ZStack(alignment: .center) {
                    HStack(alignment: .center) {
                        Spacer()
                        Text("\(viewModel.currentTemperature)")
                                .font(.system(size: 100))
                                .foregroundColor(.white)
                                .edgesIgnoringSafeArea(.all)

                        VStack(alignment:.leading) {
                            Text("°C")
                                .font(.headingL)
                                .foregroundColor(.white)
                            HStack {
                                Image(systemName: "arrow.up")
                                Text("\(viewModel.maxTemp)")
                            }
                            .font(.headingM)
                            .foregroundColor(.white)
                            HStack {
                                Image(systemName: "arrow.down")
                                Text("\(viewModel.minTemp)")
                                    
                            }
                            .font(.headingM)
                                .foregroundColor(.white)
                        }//: VStack
                        Spacer()
                    }//: HStack
                }//: ZStack center
                
                
                viewModel.weatherIcon //: Icon
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150)
                    .foregroundColor(.white)
                    .padding()
                
                Text(viewModel.weatherDescription)
                    .font(.headingL)
                    .foregroundColor(.white)
                
                Spacer()
                
                HStack(spacing: 0) {
                    ForecastView(weatherColor: $viewModel.day1Color,
                                 icon: $viewModel.day1Icon,
                                 dayName: $viewModel.day1name,
                                 maxTemp: $viewModel.day1MaxTemp,
                                 minTemp: $viewModel.day1MinTemp)

                    ForecastView(weatherColor: $viewModel.day2Color,
                                 icon: $viewModel.day2Icon,
                                 dayName: $viewModel.day2name,
                                 maxTemp: $viewModel.day2MaxTemp,
                                 minTemp: $viewModel.day2MinTemp)

                    ForecastView(weatherColor: $viewModel.day3Color,
                                 icon: $viewModel.day3Icon,
                                 dayName: $viewModel.day3name,
                                 maxTemp: $viewModel.day3MaxTemp,
                                 minTemp: $viewModel.day3MinTemp)

                    ForecastView(weatherColor: $viewModel.day4Color,
                                 icon: $viewModel.day4Icon,
                                 dayName: $viewModel.day4name,
                                 maxTemp: $viewModel.day4MaxTemp,
                                 minTemp: $viewModel.day4MinTemp)
                }
                .padding(.bottom)
                
            }
            
            .onAppear() {
                print("YEAH")
                viewModel.getWeatherForLocation("Tokyo")
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    viewModel.getForecastForLocation("Tokyo")
                }
            }
        }//: ZStack
        .background(viewModel.weatherColor)
    }
}

// MARK: - Preview
struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
            .background(Color.weather.clear)
    }
}
