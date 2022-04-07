//
//  CurrentWeatherViewModel.swift
//  WeatherDemo
//
//  Created by Jérôme Figueiredo on 06/04/2022.
//

import Foundation
import Combine

class CurrentWeatherViewModel: ObservableObject {
    // MARK: - Properties
    @Published var coordinates: Array<Double> = [Double]()
    @Published var currentTemperature: Int = 0
    
    @Published var day1ForecastTemp: Int = 0
    @Published var day2ForecastTemp: Int = 0
    @Published var day3ForecastTemp: Int = 0
    @Published var day4ForecastTemp: Int = 0
    
    @Published var day1ForecastMinTemp: Int = 0
    @Published var day2ForecastMinTemp: Int = 0
    @Published var day3ForecastMinTemp: Int = 0
    @Published var day4ForecastMinTemp: Int = 0
    
    private var cancellable: AnyCancellable?
    
    // MARK: - Methods
    // MARK: - Weather methods
    func getWeatherForLocation(_ location: String) {
        var geoInfo: GeocodingModel = GeocodingModel.emptyModel()
        
        cancellable = ApiService().getGeoForCity(city: location)
            .sink(receiveCompletion: { _ in
                self.getWeatherFromGeo(geoInfo)
            }, receiveValue: { geo in
                print("Geo Info: \(geo)")
                geoInfo = geo[0]
            })
    }
    
    func getWeatherFromGeo(_ geoInfo: GeocodingModel){
        cancellable = ApiService().getWeatherForLocation(geoInfo.lat, geoInfo.lon, "metric")
            .sink(receiveCompletion: { _ in
                print("Done fetching weather")
            }, receiveValue: { weather in
//                print("WEATHER -------> \(weather)")
//                print("WEATHER WEATHER -------> \(weather.main.temp)")
//                print("WEATHER DESCRIPTION -------> \(weather.weather[0].weatherDescription)")
//                print("WEATHER ICON -------> \(weather.weather[0].icon)")
                
//                let date = Date(timeIntervalSince1970: TimeInterval(weather.dt))
//                print("DATE: \(date)")
//                
                self.currentTemperature = Int(weather.main.temp.rounded())
            })
    }
    
    // MARK: - Forecast methods
    func getForecastForLocation(_ location: String) {
        var geoInfo: GeocodingModel = GeocodingModel.emptyModel()
        
        cancellable = ApiService().getGeoForCity(city: location)
            .sink(receiveCompletion: { _ in
                self.getForecastFromGeo(geoInfo)
            }, receiveValue: { geo in
                print("Geo Info: \(geo)")
                geoInfo = geo[0]
            })
    }
    
    func getForecastFromGeo(_ geoInfo: GeocodingModel){
        cancellable = ApiService().getForecast(geoInfo.lat, geoInfo.lon, "metric")
            .sink(receiveCompletion: { _ in
                print("Done fetching Forecast")
            }, receiveValue: { day in
                self.day1ForecastTemp = Int(day.daily[1].temp.max.rounded())
                self.day2ForecastTemp = Int(day.daily[2].temp.max.rounded())
                self.day3ForecastTemp = Int(day.daily[3].temp.max.rounded())
                self.day4ForecastTemp = Int(day.daily[4].temp.max.rounded())
                
                self.day1ForecastMinTemp = Int(day.daily[1].temp.min.rounded())
                self.day2ForecastMinTemp = Int(day.daily[2].temp.min.rounded())
                self.day3ForecastMinTemp = Int(day.daily[3].temp.min.rounded())
                self.day4ForecastMinTemp = Int(day.daily[4].temp.min.rounded())
                
//                print("Forecast day 1 -------> \(day.daily[1])")
//                print("Forecast day 2 -------> \(day.daily[2])")
//                print("Forecast day 3 -------> \(day.daily[3])")
//                print("Forecast day 4 -------> \(day.daily[4])")
            })
    }
}
