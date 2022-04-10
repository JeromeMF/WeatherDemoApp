//
//  RequestLocationView.swift
//  WeatherDemo
//
//  Created by Jérôme Figueiredo on 10/04/2022.
//

import SwiftUI

struct RequestLocationView: View {
    @EnvironmentObject var locationViewModel: LocationViewModel
    
    var body: some View {
        VStack {
            Image(systemName: "location.magnifyingglass")
                .resizable()
                .frame(width: 100, height: 100, alignment: .center)
                .foregroundColor(Color.weather.rain)
                .padding(.bottom)
            Button(action: {
                locationViewModel.requestPermission()
            }, label: {
                Label("Allow tracking", systemImage: "location")
            })
            .padding(10)
            .foregroundColor(.white)
            .background(Color.weather.rain)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            Text("The Weather Demo app needs your location to display accurate data.")
                .foregroundColor(.gray)
                .font(.caption)
                .multilineTextAlignment(.center)
        }
    }
}

struct RequestLocationView_Previews: PreviewProvider {
    static var previews: some View {
        RequestLocationView()
    }
}
