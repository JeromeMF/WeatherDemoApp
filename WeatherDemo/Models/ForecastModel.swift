//
//  ForecastModel.swift
//  WeatherDemo
//
//  Created by Jérôme Figueiredo on 07/04/2022.
//

import Foundation

// MARK: - Forecast
struct ForecastModel: Codable {
    let lat: Double
    let lon: Double
    let timezone: String
    let timezoneOffset: Int
    let daily: [Daily]
    
    enum CodingKeys: String, CodingKey {
        case lat
        case lon
        case timezone
        case timezoneOffset = "timezone_offset"
        case daily
    }
}

// MARK: - Daily
struct Daily: Codable {
    let dt: Int
    let sunrise: Int
    let sunset: Int
    let moonrise: Int
    let moonset: Int
    let moonPhase: Double
    let temp: Temp
    let feelsLike: FeelsLike
    let pressure: Int
    let humidity: Int
    let dewPoint: Double
    let windSpeed: Double
    let windDeg: Int
    let windGust: Double
    let weather: [Weather]
    let clouds: Int
    let pop: Double
    let rain: Double?
    let uvi: Double
    
    enum CodingKeys: String, CodingKey {
        case dt
        case sunrise
        case sunset
        case moonrise
        case moonset
        case moonPhase = "moon_phase"
        case temp
        case feelsLike = "feels_like"
        case pressure
        case humidity
        case dewPoint = "dew_point"
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
        case windGust = "wind_gust"
        case weather
        case clouds
        case pop
        case rain
        case uvi
    }
}

// MARK: - FeelsLike
struct FeelsLike: Codable {
    let day: Double
    let night: Double
    let eve: Double
    let morn: Double
}

// MARK: - Temp
struct Temp: Codable {
    let day: Double
    let min: Double
    let max: Double
    let night: Double
    let eve: Double
    let morn: Double
}

// MARK: - Empty model
extension ForecastModel {
    static func emptyModel() -> ForecastModel {
        return ForecastModel(lat: 0,
                             lon: 0,
                             timezone: "",
                             timezoneOffset: 0,
                             daily: [Daily(dt: 0,
                                           sunrise: 0,
                                           sunset: 0,
                                           moonrise: 0,
                                           moonset: 0,
                                           moonPhase: 0,
                                           temp: Temp(day: 0.0,
                                                      min: 0.0,
                                                      max: 0.0,
                                                      night: 0.0,
                                                      eve: 0.0,
                                                      morn: 0.0),
                                           feelsLike: FeelsLike(day: 0.0,
                                                                night: 0.0,
                                                                eve: 0.0,
                                                                morn: 0.0),
                                           pressure: 0,
                                           humidity: 0,
                                           dewPoint: 0.0,
                                           windSpeed: 0.0,
                                           windDeg: 0,
                                           windGust: 0.0,
                                           weather: [Weather(id: 0,
                                                             main: "",
                                                             weatherDescription: "",
                                                             icon: "")],
                                           clouds: 0,
                                           pop: 0.0,
                                           rain: 0.0,
                                           uvi: 0.0)])
    }
}
