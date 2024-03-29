//
//  ForecastDayView.swift
//  WeatherDemo
//
//  Created by Jérôme Figueiredo on 10/04/2022.
//

import SwiftUI

struct ForecastDayView: View {
    // MARK: - Properties
    @Binding var weatherColor: Color
    @Binding var icon: Image
    @Binding var dayName: String
    @Binding var maxTemp: Int
    @Binding var minTemp: Int
    @Binding var isLoading: Bool
    
    // MARK: - Body
    var body: some View {
        ZStack {
            Color.black
                .opacity(0.1)
                .ignoresSafeArea()
            
            VStack() {
                HStack() {
                    ProgressView()
                        .tint(Color.weather.rain)
                        .scaleEffect(1.5)
                        .opacity(isLoading ? 0 : 1)
                }//: HStack
            }//: VStack
            
            VStack {
                Text(dayName.uppercased())
                    .font(.subtitleS)
                    .foregroundColor(.white)
                    .padding(.top)
                
                icon
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40)
                    .foregroundColor(.white)
                
                Text("\(maxTemp)° / \(minTemp)°")
                    .font(.subtitleS)
                    .foregroundColor(.white)
                    .padding(.bottom)
            }//: VStack
            .padding(.horizontal, 5)
            .opacity(isLoading ? 1 : 0)
            .animation(.default)
        }//: ZStack
        .background(weatherColor)
        .frame(width: UIScreen.main.bounds.size.width / 4, height: 130)
        .overlay(Divider(), alignment: .leading)
    }
}

struct ForecastDayView_Previews: PreviewProvider {
    static var previews: some View {
        ForecastDayView(weatherColor: .constant(Color.weather.clear),
                        icon: .constant(Image("thunderstorm")),
                        dayName: .constant("Tue"),
                        maxTemp: .constant(104),
                        minTemp: .constant(80),
                        isLoading: .constant(false))
        .previewLayout(.sizeThatFits)
    }
}
