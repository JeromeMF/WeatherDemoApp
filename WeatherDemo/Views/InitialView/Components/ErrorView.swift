//
//  ErrorView.swift
//  WeatherDemo
//
//  Created by Jérôme Figueiredo on 10/04/2022.
//

import SwiftUI

struct ErrorView: View {
    // MARK: - Properties
    var errorText: String
    @State var goToWeather: Bool = false
    
    // MARK: - Body
    var body: some View {
        VStack {
            Image(systemName: "xmark.octagon")
                .resizable()
                .frame(width: 100, height: 100, alignment: .center)
                .padding()
            Text(errorText)
                .multilineTextAlignment(.center)
                .padding(.bottom, 50)
            
            NavigationLink(destination: WeatherView(), isActive: $goToWeather, label: {
                Button(action: {
                    goToWeather.toggle()
                }, label: {
                    Text("Dismiss")
                        .font(.headingL)
                })
            })
        }//: VStack
        .padding()
        .foregroundColor(Color.weather.rain)
    }
}

// MARK: - Preview
struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(errorText: "Location use is restricted.")
    }
}
