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
    
    private var cancellable: AnyCancellable?
    
    // MARK: - Init
    init() {
//        getCoordinates()
    }
    
    // MARK: - Methods
    func getGeoInfo() {
        var geoInfo: GeocodingModel = GeocodingModel(name: "", lat: 0.0, lon: 0.0, country: "", state: "")
        
        cancellable = ApiService().getGeoInfo(city: "London")
            .sink(receiveCompletion: { _ in
                self.getCoordinates(geoInfo)
                
            }, receiveValue: {
//                print($0)
                geoInfo = $0[0]
            })
    }
    
    func getCoordinates(_ geoInfo: GeocodingModel){
        cancellable = ApiService().getWeatherForLocation(geoInfo.lat, geoInfo.lon, "metric")
            .sink(receiveCompletion: { _ in }, receiveValue: {
                print("WEATHER -------> \($0)")
            })
        print("Done")
    }
}
