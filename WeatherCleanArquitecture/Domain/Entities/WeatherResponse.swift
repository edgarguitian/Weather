//
//  WeatherResponse.swift
//  WeatherCleanArquitecture
//
//  Created by Edgar Guitian Rey on 4/1/24.
//

import Foundation

struct WeatherResponse {
    let city: String
    let weather: WeatherDataModel
    let temperature: TemperatureDataModel
    let sun: SunModel
    let timezone: Double
    
    init() {
        self.city = ""
        self.weather = WeatherDataModel(main: "", description: "", iconURLString: nil)
        self.temperature = TemperatureDataModel(currentTemperature: "", minTemperature: "", maxTemperature: "", humidity: "")
        self.sun = SunModel(sunrise: .now, sunset: .now)
        self.timezone = 0.0
    }
    
    init(city: String, weather: WeatherDataModel, temperature: TemperatureDataModel, sun: SunModel, timezone: Double) {
        self.city = city
        self.weather = weather
        self.temperature = temperature
        self.sun = sun
        self.timezone = timezone
    }
}

struct SunModel {
    let sunrise: Date
    let sunset: Date
}

struct WeatherDataModel {
    let main: String
    let description: String
    let iconURLString: URL?
    
    static let empty: WeatherDataModel = .init(main: "", description: "", iconURLString: nil)
}

struct TemperatureDataModel {
    let currentTemperature: String
    let minTemperature: String
    let maxTemperature: String
    let humidity: String
    
}
