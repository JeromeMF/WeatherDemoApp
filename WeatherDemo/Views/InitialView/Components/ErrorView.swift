//
//  ErrorView.swift
//  WeatherDemo
//
//  Created by Jérôme Figueiredo on 10/04/2022.
//

import SwiftUI

struct ErrorView: View {
    var errorText: String
    
    var body: some View {
        VStack {
            Image(systemName: "xmark.octagon")
                .resizable()
                .frame(width: 100, height: 100, alignment: .center)
                .padding()
            Text(errorText)
                .multilineTextAlignment(.center)
        }
        .padding()
        .foregroundColor(Color.weather.rain)
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(errorText: "Location use is restricted.")
    }
}
