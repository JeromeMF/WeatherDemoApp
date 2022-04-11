//
//  ApiServiceTest.swift
//  WeatherDemo
//
//  Created by Jérôme Figueiredo on 11/04/2022.
//

import XCTest
import Combine
@testable import WeatherDemo

class ApiServiceTest: XCTestCase {
    // MARK: - Properties
    private var cancellables: Set<AnyCancellable>!
    
    
    override func setUp() {
        super.setUp()
        cancellables = []
    }
    
    // MARK: - Test Get Weather from Coordinates
    func testGetWeatherByCoordinates() {
        let expectation = self.expectation(description: "Fetch weather for lat and lon (Lisbon)")
        var error: Error?
        var lon: Double = 0.0
        var lat: Double = 0.0
        var id: Int = 0
        var name: String = ""
        
        ApiService().getWeatherForLocation(38.7071, -9.1355, "metric")
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let encounteredError):
                    error = encounteredError
                }
                
                expectation.fulfill()
            }, receiveValue: { value in
                print(value)
                lat = value.coord.lat
                lon = value.coord.lon
                id = value.id
                name = value.name
            })
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 5)
        
        XCTAssertNil(error)
        XCTAssertEqual(lat, 38.7071, accuracy: 2)
        XCTAssertEqual(lon, -9.1355, accuracy: 2)
        XCTAssertEqual(id, 6930126)
        XCTAssertEqual(name, "Chiado") // Location changes slightly inside lisbon sometimes to Sacramento for example id 8012482
    }
    
    // MARK: - Test Get Geo Data from City name
    func testGetGeoFromCity() {
        let expectation = self.expectation(description: "Fetch geo data for Lisbon")
        var error: Error?
        var lon: Double = 0.0
        var lat: Double = 0.0
        var name: String = ""
        var country: String = ""
        
        ApiService().getGeoForCity(city: "Lisbon", country: "", limit: 1)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let encounteredError):
                    error = encounteredError
                }
                
                expectation.fulfill()
            }, receiveValue: { value in
                print(value)
                lat = value[0].lat
                lon = value[0].lon
                name = value[0].name
                country = value[0].country
            })
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 5)
        
        XCTAssertNil(error)
        XCTAssertEqual(lat, 38.7071, accuracy: 4)
        XCTAssertEqual(lon, -9.1355, accuracy: 4)
        XCTAssertEqual(name, "Lisbon")
        XCTAssertEqual(country, "PT")
    }
    
    func testGetForecast() {
        let expectation = self.expectation(description: "Fetch weather forecast for Lisbon")
        var error: Error?
        var forecast: ForecastModel = ForecastModel.emptyModel()
        
        ApiService().getForecast(38.7071, -9.1355, "metric")
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let encounteredError):
                    error = encounteredError
                }
                
                expectation.fulfill()
            }, receiveValue: { value in
                print(value)
                forecast = value
            })
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 5)
        
        XCTAssertNil(error)
        XCTAssertNotNil(forecast)
    }
}
