//
//  CurrentWeatherViewModel.swift
//  WeatherDemo
//
//  Created by Jérôme Figueiredo on 06/04/2022.
//

import Foundation
import Combine
import SwiftUI

class WeatherViewModel: ObservableObject {
    // MARK: - Properties
    @Published var coordinates: Array<Double> = [Double]()
    @Published var currentTemperature: Int = 0
    @Published var currentLocation: String = ""
    @Published var countryCode: String = ""
    @Published var unit: String = ""
    @Published var maxTemp: Int = 0
    @Published var minTemp: Int = 0
    @Published var weatherDescription: String = ""
    @Published var cloudCoverage: Int = 0
    @Published var windSpeed: Double = 0.0
    @Published var humidity: Int = 0
    @Published var fontColor: Color = .white
    
    @Published var currentDayName: String = ""
    
    @Published var day1name: String = ""
    @Published var day2name: String = ""
    @Published var day3name: String = ""
    @Published var day4name: String = ""
    
    @Published var day1MaxTemp: Int = 0
    @Published var day2MaxTemp: Int = 0
    @Published var day3MaxTemp: Int = 0
    @Published var day4MaxTemp: Int = 0
    
    @Published var day1MinTemp: Int = 0
    @Published var day2MinTemp: Int = 0
    @Published var day3MinTemp: Int = 0
    @Published var day4MinTemp: Int = 0
    
    @Published var day1Icon: Image = Image("clear")
    @Published var day2Icon: Image = Image("clear")
    @Published var day3Icon: Image = Image("clear")
    @Published var day4Icon: Image = Image("clear")
    
    @Published var day1Color: Color = .white
    @Published var day2Color: Color = .white
    @Published var day3Color: Color = .white
    @Published var day4Color: Color = .white
    
    //    @Published var backgroundColor: Color = .white
    @Published var weatherIcon: Image = Image("clear")
    @Published var weatherColor: Color = .white
    
    
    private var cancellable: AnyCancellable?
    
    // MARK: - Methods
    // MARK: - Weather methods
    
    // MARK: - Get geo data and call weather from geo
    func getWeatherForLocation(_ location: String) {
        var geoInfo: GeocodingModel = GeocodingModel.emptyModel()
        
        cancellable = ApiService().getGeoForCity(city: location, limit: 1)
            .sink(receiveCompletion: { _ in
                self.getWeatherFromGeo(geoInfo)
            }, receiveValue: { geo in
                print("Geo Info: \(geo)")
                geoInfo = geo[0]
                
//                self.getWeatherFromGeo(geoInfo)
                
                self.currentLocation = geo[0].name.uppercased()
                self.countryCode = geo[0].country.uppercased()
            })
    }
    
    // MARK: - Get weather from geo data
    func getWeatherFromGeo(_ geoInfo: GeocodingModel){
        cancellable = ApiService().getWeatherForLocation(geoInfo.lat, geoInfo.lon, "metric")
            .sink(receiveCompletion: { _ in
                print("Done fetching weather")
            }, receiveValue: { weather in
                print("WEATHER -------> \(weather)")
                let date = Date(timeIntervalSince1970: TimeInterval(weather.dt))
                
                self.currentTemperature = Int(weather.main.temp.rounded())
                self.maxTemp = Int(weather.main.tempMax.rounded())
                self.minTemp = Int(weather.main.tempMin.rounded())
                self.weatherDescription = weather.weather[0].weatherDescription.capitalized
                self.cloudCoverage = weather.clouds.all
                self.windSpeed = weather.wind.speed
                self.humidity = weather.main.humidity
                
                self.weatherColor = self.getColorForWeather(weather.weather[0])
                self.fontColor = self.getFontColor(weather.weather[0])
                self.weatherIcon = self.getWeatherIcon(weather.weather[0])
                self.currentDayName = self.getWeekDay(date: date)
            })
    }
    
    // MARK: - Forecast methods
    func getForecastForLocation(_ location: String) {
        var geoInfo: GeocodingModel = GeocodingModel.emptyModel()
        
        cancellable = ApiService().getGeoForCity(city: location, limit: 1)
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
            }, receiveValue: { forecast in
                print(forecast)
                
                self.day1MaxTemp = Int(forecast.daily[1].temp.max.rounded())
                self.day2MaxTemp = Int(forecast.daily[2].temp.max.rounded())
                self.day3MaxTemp = Int(forecast.daily[3].temp.max.rounded())
                self.day4MaxTemp = Int(forecast.daily[4].temp.max.rounded())
                
                self.day1MinTemp = Int(forecast.daily[1].temp.min.rounded())
                self.day2MinTemp = Int(forecast.daily[2].temp.min.rounded())
                self.day3MinTemp = Int(forecast.daily[3].temp.min.rounded())
                self.day4MinTemp = Int(forecast.daily[4].temp.min.rounded())
                
                self.day1Icon = self.getWeatherIcon(forecast.daily[1].weather[0])
                self.day2Icon = self.getWeatherIcon(forecast.daily[2].weather[0])
                self.day3Icon = self.getWeatherIcon(forecast.daily[3].weather[0])
                self.day4Icon = self.getWeatherIcon(forecast.daily[4].weather[0])
                
                self.day1Color = self.getColorForWeather(forecast.daily[1].weather[0])
                self.day2Color = self.getColorForWeather(forecast.daily[2].weather[0])
                self.day3Color = self.getColorForWeather(forecast.daily[3].weather[0])
                self.day4Color = self.getColorForWeather(forecast.daily[4].weather[0])
                
                let date = Date()
                
                let date1 = Calendar.current.date(byAdding: .day, value: 1, to: date)
                let date2 = Calendar.current.date(byAdding: .day, value: 2, to: date)
                let date3 = Calendar.current.date(byAdding: .day, value: 3, to: date)
                let date4 = Calendar.current.date(byAdding: .day, value: 4, to: date)
                
                //                var dayComponent = DateComponents()
                //                dayComponent.day = 1 // For removing one day (yesterday): -1
                //
                //                let theCalendar = Calendar.current
                //                let nextDate = theCalendar.date(byAdding: dayComponent, to: date)
                //                print("nextDate : \(nextDate)")
                
                self.day1name = date1!.dayOfWeek() ?? "N/A"//self.getWeekDay(date: date1!)
                self.day2name = date2!.dayOfWeek() ?? "N/A"
                self.day3name = date3!.dayOfWeek() ?? "N/A"
                self.day4name = date4!.dayOfWeek() ?? "N/A"
            })
    }
    
    //    func getColorForWeather(_ weather: Weather) {
    //        self.weatherColor = weather.weatherColor()
    //    }
    //
    //    func getWeatherIcon(_ weather: Weather) {
    //        self.weatherIcon = weather.weatherIcon()
    //    }
    
    func getColorForWeather(_ weather: Weather) -> Color {
        return weather.weatherColor()
    }
    
    func getWeatherIcon(_ weather: Weather) -> Image {
        return weather.weatherIcon()
    }
    
    func getFontColor(_ weather: Weather) -> Color {
        return weather.fontColor()
    }
    
    
    func getWeekDay(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let weekDay = dateFormatter.string(from: Date())
        print("WEEKDAY: \(weekDay)")
        return weekDay.uppercased()
    }
}

extension Date {
    func dayOfWeek() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self).prefix(3).capitalized
        // or use capitalized(with: locale) if you want
    }
}
