//
//  Endpoint.swift
//  Weather
//
//  Created by Marcelo on 2023-09-02.
//

import Foundation

struct Endpoint {
    let path: String
    let queryItems: [URLQueryItem]
}

extension Endpoint {
    static func getLatLon(for city: String) -> Endpoint {
        return Endpoint(
            path: "/geo/1.0/direct",
            queryItems: [
                URLQueryItem(name: "q", value: city),
                URLQueryItem(name: "limit", value:   "5"),
                URLQueryItem(name: "appid", value: Constants.appID)]
        )
    }
    
    static func getWeather(lat: Double, lon: Double) -> Endpoint {
        return Endpoint(
            path: "/data/2.5/weather",
            queryItems: [
                URLQueryItem(name: "lat", value: String(lat)),
                URLQueryItem(name: "lon", value: String(lon)),
                URLQueryItem(name: "units", value: "metric"),
                URLQueryItem(name: "appid", value: Constants.appID)
            ]
        )
    }
}

extension Endpoint {
    var url: URL? {
        var components = URLComponents()
        components.scheme = "http"
        components.host = "api.openweathermap.org"
        components.path = path
        components.queryItems = queryItems
        
        return components.url
    }
}
