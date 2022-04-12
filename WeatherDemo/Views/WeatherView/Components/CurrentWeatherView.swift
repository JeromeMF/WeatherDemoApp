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
        ZStack {
            VStack() {
                HStack() {
                    ProgressView()
                        .tint(viewModel.fontColor)
                        .scaleEffect(1.5)
                        .opacity(viewModel.weatherFinishedLoading ? 0 : 1)
                }//: HStack
            }//: VStack
            
            VStack() {
                ZStack(alignment: .center) {
                    HStack(alignment: .center) {
                        Spacer()
                        Text("\(viewModel.currentTemperature)")
                            .font(.system(size: 100))
                            .foregroundColor(viewModel.fontColor)
                            .edgesIgnoringSafeArea(.all)
                        
                        VStack(alignment:.leading) {
                            Text("°C")
                                .font(.headingL)
                                .foregroundColor(viewModel.fontColor)
                            HStack {
                                Image(systemName: "arrow.up")
                                Text("\(viewModel.maxTemp)")
                            }//: HStack
                            .font(.headingM)
                            .foregroundColor(viewModel.fontColor)
                            HStack {
                                Image(systemName: "arrow.down")
                                Text("\(viewModel.minTemp)")
                                
                            }//: HStack
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
            .opacity(viewModel.weatherFinishedLoading ? 1 : 0)
            .animation(.default)
        }
    }
}

// MARK: - Preview
struct CurrentWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentWeatherView(viewModel: WeatherViewModel())
            .previewLayout(.sizeThatFits)
            .background(Color.blue)
            .padding()
    }
}
