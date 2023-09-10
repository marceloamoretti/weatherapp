//
//  DetailView.swift
//  Weather
//
//  Created by Marcelo on 2023-09-08.
//

import SwiftUI

struct DetailView: View {
    
    @State private var isAnimating = false
    @StateObject var weatherViewModel: WeatherViewModel
    
    var city: ReverseGeocode
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.blue, .white]), startPoint: .top, endPoint: .bottom).ignoresSafeArea(.all)
                
                ScrollView(showsIndicators: false) {
                    VStack {
                        if let weather = weatherViewModel.weather {
                            Text(city.normalisedName)
                                .font(.system(size: 50))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                                .shadow(color: .black, radius: 1, x: 0.5, y: 0.5)
                            
                            Image(systemName: weather.conditionName)
                                .font(.system(size: 70))
                                .foregroundColor(.white)
                            
                            Text(String(format: "%.0f°", weather.main.temp))
                                .font(.system(size: 70))
                                .foregroundColor(.white)
                            
                            Text(weather.weather.first?.main.capitalized ?? "Cloud")
                                .font(.title)
                                .font(.callout)
                                .foregroundColor(.white)
                            
                            LazyVGrid(columns: [GridItem(), GridItem()], spacing: 10) {
                                WeatherInfoCard(icon: "thermometer.medium", description: "Feels like", value: String(format: "%.0f°", weather.main.feelsLike), width: CGFloat(geo.size.width / 2 - 20))
                                WeatherInfoCard(icon: "humidity", description: "Humidity", value: "\(weather.main.humidity)%", width: CGFloat(geo.size.width / 2 - 20))
                                WeatherInfoCard(icon: "eye.fill", description: "Visibility", value: "\(weather.visibility / 1000) km", width: CGFloat(geo.size.width / 2 - 20))
                                WeatherInfoCard(icon: "gauge.with.dots.needle.bottom.50percent", description: "Pressure", value: "\(weather.main.pressure)", complementaryDesc: "hPa", width: CGFloat(geo.size.width / 2 - 20))
                            }
                            
                            
                        } else {
                            ProgressView()
                        }
                    }
                    .padding(.horizontal)
                    .onAppear {
                        Task {
                            try await weatherViewModel.getWeather(lat: city.lat, lon: city.lon)
                        }
                }
                }
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(weatherViewModel: WeatherViewModel(), city: Constants.templateCity)
            .preferredColorScheme(.dark)
    }
}
