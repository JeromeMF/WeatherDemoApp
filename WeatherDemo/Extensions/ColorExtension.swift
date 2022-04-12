//
//  ColorExtension.swift
//  WeatherDemo
//
//  Created by Jérôme Figueiredo on 08/04/2022.
//

import SwiftUI
import UIKit

// MARK: - Color extension
extension Color {
    
    static let weather = WeatherColors()
    //    static let typography = TypographyColors()
    
    // MARK: - Weather colors
    struct WeatherColors {
        let thunderstorm = Color("Thunderstorm")
        let drizzle = Color("Drizzle")
        let rain = Color("Rain")
        let snow = Color("Snow")
        let atmosphere = Color("Atmosphere")
        let clear = Color("Clear")
        let clouds = Color("Clouds")
        let mist = Color("Mist")
    }
    
    // MARK: - Typography colors
}
