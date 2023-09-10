//
//  ReverseGeocode.swift
//  Weather
//
//  Created by Marcelo on 2023-09-01.
//

import Foundation

struct ReverseGeocode: Codable, Identifiable {
    let id = UUID()
    let name: String
    let localNames: [String: String]?
    let lat, lon: Double
    let country: String
    let state: String?
    
    var normalisedName: String {
        if let state = self.state {
            return "\(name), \(state), \(country)"
        } else {
            return "\(name), \(country)"
        }
    }

    enum CodingKeys: String, CodingKey {
        case name
        case localNames = "local_names"
        case lat, lon, country, state
    }
}
