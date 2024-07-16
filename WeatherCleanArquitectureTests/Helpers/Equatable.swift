//
//  Equatable.swift
//  WeatherCleanArquitectureTests
//
//  Created by Edgar Guitian Rey on 15/7/24.
//

import Foundation
@testable import WeatherCleanArquitecture

extension WeatherResponse: Equatable {
    public static func == (lhs: WeatherResponse, rhs: WeatherResponse) -> Bool {
        return lhs.city == rhs.city &&
        lhs.sun.sunrise == rhs.sun.sunrise &&
        lhs.sun.sunset == rhs.sun.sunset &&
        lhs.temperature.currentTemperature == rhs.temperature.currentTemperature &&
        lhs.temperature.humidity == rhs.temperature.humidity &&
        lhs.temperature.maxTemperature == rhs.temperature.maxTemperature &&
        lhs.temperature.minTemperature == rhs.temperature.minTemperature &&
        lhs.timezone == rhs.timezone &&
        lhs.weather.description == rhs.weather.description
    }
    
    
}

extension WeatherResponseDTO: Equatable {
    public static func == (lhs: WeatherResponseDTO, rhs: WeatherResponseDTO) -> Bool {
        return lhs.city == rhs.city &&
        lhs.sun.sunrise == rhs.sun.sunrise &&
        lhs.sun.sunset == rhs.sun.sunset &&
        lhs.temperature.currentTemperature == rhs.temperature.currentTemperature &&
        lhs.temperature.humidity == rhs.temperature.humidity &&
        lhs.temperature.maxTemperature == rhs.temperature.maxTemperature &&
        lhs.temperature.minTemperature == rhs.temperature.minTemperature &&
        lhs.timezone == rhs.timezone &&
        lhs.weather.description == rhs.weather.description
    }
    
    
}
