//
//  ContentView.swift
//  Weather
//
//  Created by Marcelo on 2023-09-01.
//

import SwiftUI


struct ContentView: View {
    @StateObject var weatherViewModel: WeatherViewModel = WeatherViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                List {
                    switch(weatherViewModel.status) {
                    case .loaded:
                        ForEach(weatherViewModel.cities) {city in
                            NavigationLink {
                                DetailView(weatherViewModel: weatherViewModel, city: city)
                            } label: {
                                Text(city.normalisedName)
                            }
                        }
                    case .loading:
                        ProgressView()
                            .frame(maxWidth: .infinity)
                    case .error:
                        Text("Something went wrong, try again!")
                        
                    case .empty:
                        Text("Search for a city")
                    }
                }
                .searchable(text: $weatherViewModel.searchTerm)
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
