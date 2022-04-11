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
        cancellable = ApiService().getGeoForCity(city: location, country: "", limit: 5)
            .sink(receiveCompletion: { _ in
                
            }, receiveValue: { geos in
                for geo in geos {
                    self.result.append(geo)
                }
            })
    }
    
    func clearResult() {
        self.result.removeAll()
    }
}
