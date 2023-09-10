//
//  WeatherInfoCard.swift
//  Weather
//
//  Created by Marcelo on 2023-09-10.
//

import SwiftUI

struct WeatherInfoCard: View {
    var icon: String
    var description: String
    var value: String
    var complementaryDesc: String?
    var width: Double
    
    var body: some View {
            VStack {
                HStack {
                    Image.init(systemName: icon)
                    Text(description)
                    
                    Spacer()
                }
                .foregroundColor(.white.opacity(0.75))
                .font(.title3)
                .padding([.top, .horizontal])
                
                Spacer()
                
                Text(value)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                if let compDesc = complementaryDesc {
                    Text(compDesc)
                        .font(.headline)
                }
                
                Spacer()
                
            }
            .foregroundColor(.white)
            .frame(width: width, height: 150)
            .background(.thinMaterial)
            .cornerRadius(20)
            .lineLimit(1)
            .minimumScaleFactor(0.5)
    }
}

struct WeatherInfoCard_Previews: PreviewProvider {
    static var previews: some View {
        WeatherInfoCard(icon: "thermometer.medium", description: "Feels like", value: "21", complementaryDesc: "", width: 150)
            .background(.blue)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
