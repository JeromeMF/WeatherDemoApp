//
//  ApiService.swift
//  WeatherDemo
//
//  Created by Jérôme Figueiredo on 05/04/2022.
//

import Foundation
import Combine

class ApiWebservice {
    
    // MARK: - Propertird
    let API_KEY = "be6096e24c86b077e38b14508ddce705"
    let BASE_URL_GEO = "http://api.openweathermap.org/geo/1.0/"
    let BASE_URL_WEATHER = "https://api.openweathermap.org/data/2.5/"
    
    // MARK: - Get Coordinates from city name
    func getCoordinates(_ city: String) -> AnyPublisher<GeoModel, Error> {
                guard let url = URL(string: BASE_URL_GEO + "direct?q=" + city + "&appid=" + API_KEY) else {
                    fatalError("Invalid URL")
                }
        
                let publisher = URLSession.shared.dataTaskPublisher(for: url)
                    .receive(on: RunLoop.main)
                    .map(\.data)
                    .decode(type: GeoModel.self, decoder: JSONDecoder())
                    .eraseToAnyPublisher()
        
                return publisher
    }
    
    // MARK: - Get weather from coordinates
    func getWeatherForLocation(_ lon: String, _ lat: String) -> AnyPublisher<CurrentWeatherModel, Error> {
        guard let url = URL(string: BASE_URL_WEATHER + "weather?lat=" + lat + "&lon=" + lon +  "&appid=\(API_KEY)") else {
            fatalError("Invalid URL")
        }

        let publisher = URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: RunLoop.main)
            .map(\.data)
            .decode(type: CurrentWeatherModel.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()

        return publisher
    }

}
