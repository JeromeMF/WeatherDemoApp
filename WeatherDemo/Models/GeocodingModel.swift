//
//  GeocodingModel.swift
//  WeatherDemo
//
//  Created by Jérôme Figueiredo on 06/04/2022.
//

import Foundation

// MARK: - GeocodingModel
struct GeocodingModel: Codable {
    let name: String
    //        let localNames: LocalNames
    let lat: Double
    let lon: Double
    let country: String
    let state: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        //                case localNames = "local_names"
        case lat
        case lon
        case country
        case state
    }
    
    //    static let emptyGeo: GeocodingModel
}

// MARK: - LocalNames (Disabled for this demos)
struct LocalNames: Codable {
    let featureName: String
    let ascii: String
    let en: String
    let af, ar: String?
    let az, bg, ca, da: String?
    let de, el: String?
    let eu, fa: String?
    let fi, fr, gl, he: String?
    let hi, hr, hu, id: String?
    let it, ja, la, lt: String?
    let mk, nl, no, pl: String?
    let pt, ro, ru, sk: String?
    let sl, sr, th, tr: String?
    let vi, zu: String?
    
    enum CodingKeys: String, CodingKey {
        case featureName = "feature_name"
        case ascii
        case af, ar, az, bg, ca, da, de, el, en, eu, fa
        case fi, fr, gl, he, hi, hr, hu, id, it, ja, la
        case lt, mk, nl, no, pl, pt, ro, ru, sk, sl, sr, th, tr, vi, zu
    }
}

typealias GeoModel = [GeocodingModel]

// MARK: - Placeholder
extension GeocodingModel {
    static func emptyModel() -> GeocodingModel {
        return GeocodingModel(name: "", lat: 0.0, lon: 0.0, country: "", state: "")
    }
}
