//
//  WeatherView.swift
//  WeatherCleanArquitecture
//
//  Created by Edgar Guitian Rey on 4/1/24.
//

import SwiftUI

struct WeatherView: View {
    @ObservedObject private var viewModel: WeatherViewModel
    
    init(viewModel: WeatherViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            if viewModel.showLoadingSpinner {
                ProgressView()
            } else {
                if viewModel.showErrorMessage == nil {
                    ZStack {
                        VStack {
                            
                            // MARK: Ciudad
                            Text(viewModel.weatherInfo.city)
                                .foregroundColor(.white)
                                .font(.system(size: 50))
                            
                            // MARK: Descripcion
                            Text(viewModel.weatherInfo.weather.description.uppercased())
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding(.bottom, 8)
                            
                            // MARK: icono y temperatura
                            HStack {
                                if let url = viewModel.weatherInfo.weather.iconURLString {
                                    AsyncImage(url: url) { image in
                                        image
                                    } placeholder: {
                                        ProgressView()
                                    }
                                }
                                Text(viewModel.weatherInfo.temperature.currentTemperature)
                                    .font(.system(size: 70))
                                    .foregroundColor(.white)
                            }
                            .padding(.top, -20)
                            
                            // MARK: Máximo y mínimo
                            HStack(spacing: 40) {
                                Label(viewModel.weatherInfo.temperature.maxTemperature, systemImage: "thermometer.sun.fill")
                                Label(viewModel.weatherInfo.temperature.minTemperature, systemImage: "thermometer.snowflake")
                            }
                            .symbolRenderingMode(.multicolor)
                            .foregroundColor(.white)
                            
                            Divider()
                                .padding()
                            
                            // MARK: Sunrise y Sunset
                            HStack(spacing: 40) {
                                VStack {
                                    Image(systemName: "sunrise.fill")
                                        .symbolRenderingMode(.multicolor)
                                    Text(viewModel.weatherInfo.sun.sunrise, style: .time)
                                }
                                VStack {
                                    Image(systemName: "sunset.fill")
                                        .symbolRenderingMode(.multicolor)
                                    Text(viewModel.weatherInfo.sun.sunset, style: .time)
                                }
                            }
                            .foregroundColor(.white)
                            
                            Divider()
                                .padding()
                            
                            // MARK: Humedad
                            Label(viewModel.weatherInfo.temperature.humidity, systemImage: "humidity.fill")
                                .symbolRenderingMode(.multicolor)
                                .foregroundColor(.white)
                            
                            Spacer()
                        }
                        .padding(.top, 32)
                    }
                    .background(
                        LinearGradient(colors: [.blue, .purple], startPoint: .topLeading, endPoint: .bottomTrailing)
                    )
                } else {
                    Text(viewModel.showErrorMessage!)
                }
            }
        }
        .onAppear {
            Task {
                await viewModel.onAppear(city: "Barcelona")
            }
        }
    }
}

#Preview {
    WeatherFactory.create()
}
