//
//  WeatherModel.swift
//  WeatherDemo
//
//  Created by Jérôme Figueiredo on 06/04/2022.
//

import Foundation
import SwiftUI

// MARK: - CurrentWeatherModel
struct WeatherModel: Codable {
    let coord: Coord
    let weather: [Weather]
    let base: String
    let main: Main
    let visibility: Int
    let wind: Wind
    let clouds: Clouds
    let dt: Int
    //    let sys: Sys
    let timezone: Int
    let id: Int
    let name: String
    let cod: Int
}

// MARK: - Clouds
struct Clouds: Codable {
    let all: Int
}

// MARK: - Coord
struct Coord: Codable {
    let lon: Double
    let lat: Double
}

// MARK: - Main
struct Main: Codable {
    let temp: Double
    let feelsLike: Double
    let tempMin: Double
    let tempMax: Double
    let pressure: Int
    let humidity: Int
    
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case humidity
    }
}

// MARK: - Sys
struct Sys: Codable {
    let type: Int
    let id: Int
    let message: Double
    let country: String
    let sunrise: Int
    let sunset: Int
}

// MARK: - Weather
struct Weather: Codable {
    let id: Int
    let main: String
    let weatherDescription: String
    let icon: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case main
        case weatherDescription = "description"
        case icon
    }
}

// MARK: - Wind
struct Wind: Codable {
    let speed: Double
    let deg: Int
}

extension Weather {
    
    func weatherIcon() -> Image {
        switch id {
        case 200, 201, 202, 210, 211, 212, 221, 230, 231, 232:
            return Image("thunderstorm")
        case 300, 301, 302, 310, 311, 312, 313, 314, 321:
            return Image("showerRain")
        case 500, 501, 502, 503, 504:
            return Image("rain")
        case 511:
            return Image("snow")
        case 520, 521, 522, 531:
            return Image("showerRain")
        case 600, 601, 602, 611, 612, 613, 615, 616, 620, 621, 622:
            return Image("snow")
        case 701, 711, 721, 731, 741, 751, 761, 762, 771, 781:
            return Image("mist")
        case 800:
            return Image("clear")
        case 801:
            return Image("fewClouds")
        case 802:
            return Image("scateredClouds")
        case 803, 804:
            return Image("brokenClouds")
        default:
            return Image("clear")
        }
    }
    
    func weatherColor() -> Color {
        switch id {
        case 200, 201, 202, 210, 211, 212, 221, 230, 231, 232:
            return Color.weather.thunderstorm
        case 300, 301, 302, 310, 311, 312, 313, 314, 321:
            return Color.weather.rain
        case 500, 501, 502, 503, 504:
            return Color.weather.rain
        case 511:
            return Color.weather.snow
        case 520, 521, 522, 531:
            return Color.weather.rain
        case 600, 601, 602, 611, 612, 613, 615, 616, 620, 621, 622:
            return Color.weather.snow
        case 701, 711, 721, 731, 741, 751, 761, 762, 771, 781:
            return Color.weather.mist
        case 800:
            return Color.weather.clear
        case 801:
            return Color.weather.clouds
        case 802:
            return Color.weather.clouds
        case 803, 804:
            return Color.weather.clouds
        default:
            return Color.weather.clear
        }
    }
    
    func fontColor() -> Color {
        switch id {
        case 511:
            return Color.weather.rain
        case 600, 601, 602, 611, 612, 613, 615, 616, 620, 621, 622:
            return Color.weather.rain
        case 701, 711, 721, 731, 741, 751, 761, 762, 771, 781:
            return Color.weather.rain
        case 801, 802, 803, 804:
            return Color.weather.rain
        default:
            return Color.white
        }
    }
}

// MARK: - Empty weather model
extension WeatherModel {
    static func emptyModel() -> WeatherModel {
        return WeatherModel(coord: Coord(lon: 0,
                                         lat: 0),
                            weather: [Weather(id: 0,
                                              main: "",
                                              weatherDescription: "",
                                              icon: "")],
                            base: "",
                            main: Main(temp: 0.0,
                                       feelsLike: 0.0,
                                       tempMin: 0.0,
                                       tempMax: 0.0,
                                       pressure: 0,
                                       humidity: 0),
                            visibility: 0,
                            wind: Wind(speed: 0.0,
                                       deg: 0),
                            clouds: Clouds(all: 0),
                            dt: 0,
                            timezone: 0,
                            id: 0,
                            name: "",
                            cod: 0)
    }
}
