//
//  LocationViewModel.swift
//  WeatherDemo
//
//  Created by Jérôme Figueiredo on 08/04/2022.
//

import Foundation
import CoreLocation

class LocationViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    // MARK: - Properties
    @Published var authorizationStatus: CLAuthorizationStatus
    @Published var lastSeenLocation: CLLocation?
    @Published var currentPlacemark: CLPlacemark?
    @Published var errorMessage: String = ""
    @Published var acceptedPermission: Bool = false
    
    private let locationManager: CLLocationManager
    
    // MARK: - Init
    override init() {
        locationManager = CLLocationManager()
        authorizationStatus = locationManager.authorizationStatus
        
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    
    // MARK: - Methods
    func requestPermission() {
        locationManager.requestWhenInUseAuthorization()
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationStatus = manager.authorizationStatus
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastSeenLocation = locations.first
        fetchCountryAndCity(for: locations.first)
    }

    func fetchCountryAndCity(for location: CLLocation?) {
        guard let location = location else { return }
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            self.currentPlacemark = placemarks?.first
        }
    }
    
    func checkStatus() {
        switch authorizationStatus {
        case .notDetermined:
            return
        case .restricted:
            acceptedPermission = false
            errorMessage = "Location use is restricted."
        case .denied:
            acceptedPermission = false
            errorMessage =  "The app does not have location permissions. Please enable them in settings if you want accurate data. \nDefault location used: London"
        case .authorizedAlways, .authorizedWhenInUse:
            acceptedPermission = true
        @unknown default:
            errorMessage = "Unexpected status"
        }
    }
}
