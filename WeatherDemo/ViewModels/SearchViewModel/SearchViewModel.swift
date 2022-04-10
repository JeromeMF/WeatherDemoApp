//
//  SearchViewModel.swift
//  WeatherDemo
//
//  Created by Jérôme Figueiredo on 10/04/2022.
//

import Foundation
import Combine
import SwiftUI

class SearchViewModel: ObservableObject {
    // MARK: - Properties
    private var cancellable: AnyCancellable?
    
    @Published var result: [GeocodingModel] = []
    
    // MARK: - Methods
    func searchLocations(_ location: String) {
//        var geoInfo: GeocodingModel = GeocodingModel.emptyModel()
        
        cancellable = ApiService().getGeoForCity(city: location, limit: 5)
            .sink(receiveCompletion: { _ in
               
            }, receiveValue: { geos in
                print("SEARCHHHHH : \(geos)")
//                geoInfo = geo[0]

                for geo in geos {
//                    self.result[geo.name] = geo.country
                    self.result.append(geo)
                    print("RESULT: \(geo.name) \(geo.country)")
                }
            })
    }
    
    func clearResult() {
        self.result.removeAll()
    }
}
