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
    
    @State private var showingSearch: Bool = false
    @State var currentLocation: String = "Lisbon"
    @State var currentCountry: String = "PT"
    
    init() {
        viewModel.getWeather(currentLocation, currentCountry)
    }
    
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
                .foregroundColor(viewModel.fontColor)
                
                HStack {
                    ConditionElementsView(viewModel: viewModel)
                    Spacer()
                } //: HStack
                
                CurrentWeatherView(viewModel: viewModel)
                
                HStack() {
                    Button(action: {
                        showingSearch.toggle()
                        print("search")
                    },
                           label: { Image(systemName: "magnifyingglass")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30)
                    })
                    
                    Spacer()
                    
                    Button(action: {
                        viewModel.getWeather(currentLocation, currentCountry)
                        print("refresh")
                    },
                           label: { Image(systemName: "arrow.triangle.2.circlepath")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30)
                    })
                    
                }
                .foregroundColor(viewModel.fontColor)
                .padding(24)
                
                ForecastView(viewModel: viewModel)
                    .edgesIgnoringSafeArea(.bottom)
            }
//            .onAppear() {
                //                viewModel.getWeatherForLocation("Lisbon")
                //
                //                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                //                    viewModel.getForecastForLocation("Lisbon")
                //                }
//            }
            //            .onReceive($selectedResult) {_ in
            //                print(selectedResult)
            //            }
//            .onReceive($currentLocation) { _ in
//                print(currentLocation)
//            }
            .onChange(of: currentLocation) { _ in
                viewModel.getWeather(currentLocation, currentCountry)
                        }
            .sheet(isPresented: $showingSearch) {
                SearchView(selectedLocation: $currentLocation,
                           selectedCountry: $currentCountry)
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
