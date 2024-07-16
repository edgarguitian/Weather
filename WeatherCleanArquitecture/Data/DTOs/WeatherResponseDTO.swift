//
//  WeatherResponseDTO.swift
//  WeatherCleanArquitecture
//
//  Created by Edgar Guitian Rey on 4/1/24.
//

import Foundation

struct WeatherResponseDTO: Decodable {
    let city: String
    let weather: [WeatherDataModelDTO]
    let temperature: TemeperatureDataModelDTO
    let sun: SunModelDTO
    let timezone: Double
    
    enum CodingKeys: String, CodingKey {
        case city = "name"
        case weather
        case temperature = "main"
        case sun = "sys"
        case timezone
    }
}

struct SunModelDTO: Decodable {
    let sunrise: Date
    let sunset: Date
}

struct WeatherDataModelDTO: Decodable {
    let main: String
    let description: String
    let iconURLString: String
    
    enum CodingKeys: String, CodingKey {
        case main
        case description
        case iconURLString = "icon"
    }
}

struct TemeperatureDataModelDTO: Decodable {
    let currentTemperature: Double
    let minTemperature: Double
    let maxTemperature: Double
    let humidity: Int
    
    enum CodingKeys: String, CodingKey {
        case currentTemperature = "temp"
        case minTemperature = "temp_min"
        case maxTemperature = "temp_max"
        case humidity
    }
}
