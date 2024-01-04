//
//  GetWeatherType.swift
//  WeatherCleanArquitecture
//
//  Created by Edgar Guitian Rey on 4/1/24.
//

import Foundation

protocol GetWeatherType {
    func execute(city: String) async -> Result<WeatherResponse, WeatherDomainError>
}
