//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Marcelo on 2023-09-01.
//

import Foundation
import Combine

@MainActor
class WeatherViewModel: ObservableObject {
    
    enum Status: Comparable {
        case empty
        case loaded
        case loading
        case error
    }
    
    @Published var searchTerm: String = ""
    @Published var status: Status = .empty
    @Published var cities: [ReverseGeocode] = [ReverseGeocode]()
    @Published var weather: Weather?
    
    var subscriptions = Set<AnyCancellable>()
    
    init() {
        $searchTerm
            .dropFirst()
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .sink { term in
                if !term.isEmpty {
                    Task {
                        try await self.getLatLon(for: term.encodeCity(term))
                    }
                } else {
                    self.status = .empty
                }
            }.store(in: &subscriptions)
    }
    
    func getLatLon(for city: String) async throws {
        guard status != .loading else {
            return
        }
        
        status = .loading
        
        guard !searchTerm.isEmpty else {
            status = .error
            return
        }
        
        cities = try await NetworkService.shared.fetch(endpoint: .getLatLon(for: city)) as [ReverseGeocode]
        status = .loaded
    }
    
    
    func getWeather(lat: Double, lon: Double) async throws {
        weather = try await NetworkService.shared.fetch(endpoint: .getWeather(lat: lat, lon: lon)) as Weather
    }
}
