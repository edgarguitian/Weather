//
//  WeatherRepositoryType.swift
//  WeatherCleanArquitecture
//
//  Created by Edgar Guitian Rey on 4/1/24.
//

import Foundation

protocol WeatherRepositoryType {
    func getWeather(city: String) async -> Result<WeatherResponse, WeatherDomainError>
}
