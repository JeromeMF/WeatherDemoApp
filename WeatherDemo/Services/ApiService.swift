//
//  ApiService.swift
//  WeatherDemo
//
//  Created by Jérôme Figueiredo on 05/04/2022.
//

import Foundation
import Combine

class ApiService {
    
    // MARK: - Propertird
    let API_KEY = "be6096e24c86b077e38b14508ddce705"
    let BASE_URL_GEO = "http://api.openweathermap.org/geo/1.0/"
    let BASE_URL_WEATHER = "https://api.openweathermap.org/data/2.5/"
    
    private var cancellable: AnyCancellable?
    
    // MARK: - Get Coordinates from city name
    func getGeoForCity(city: String, country: String, limit: Int) -> AnyPublisher<GeoModel, Error> {
        let city = city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        guard let city = city else { fatalError("Invalid URL") }
        
        guard let url = URL(string: BASE_URL_GEO + "direct?q=" + city + "," + country + "&limit=" + "\(limit)" + "&appid=" + API_KEY) else {
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
    func getWeatherForLocation(_ lat: Double, _ lon: Double, _ units: String) -> AnyPublisher<WeatherModel, Error> {
        guard let url = URL(string: BASE_URL_WEATHER + "weather?lat=" + "\(lat)" + "&lon=" + "\(lon)" + "&units=" + units + "&appid=\(API_KEY)") else {
            fatalError("Invalid URL")
        }
        
        let publisher = URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: RunLoop.main)
            .map(\.data)
            .decode(type: WeatherModel.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
        
        return publisher
    }
    
    // MARK: - Get 4 days forecast
    func getForecast(_ lat: Double, _ lon: Double, _ units: String) -> AnyPublisher<ForecastModel, Error> {
        guard let url = URL(string: BASE_URL_WEATHER + "onecall?lat=" + "\(lat)" + "&lon=" + "\(lon)" + "&exclude=current,hourly,minutely,alert" + "&units=" + units + "&appid=\(API_KEY)") else {
            fatalError("Invalid URL")
        }
        
//        print(url)
        
        let publisher = URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: RunLoop.main)
            .map(\.data)
            .decode(type: ForecastModel.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
        
        return publisher
    }
    
}
