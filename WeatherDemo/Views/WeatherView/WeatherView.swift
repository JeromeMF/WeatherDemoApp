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
    //    @StateObject var locationViewModel = LocationViewModel()
    @State private var showingSearch = false
    
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
                        print("serach")
                    },
                           label: { Image(systemName: "magnifyingglass")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30)
                    })
                    
                    
                    
                    Spacer()
                    
                }
                .foregroundColor(viewModel.fontColor)
                .padding(24)
                
                ForecastView(viewModel: viewModel)
                    .edgesIgnoringSafeArea(.bottom)
            }
            .onAppear() {
                viewModel.getWeatherForLocation("Lisbon")
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    viewModel.getForecastForLocation("Lisbon")
                }
            }
            .sheet(isPresented: $showingSearch) {
                SearchView(selectedResult: .constant(""))
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
