//
//  APIWeatherDataSourceType.swift
//  WeatherCleanArquitecture
//
//  Created by Edgar Guitian Rey on 4/1/24.
//

import Foundation

protocol APIWeatherDataSourceType {
    func getWeather(city: String) async -> Result<WeatherResponseDTO, HTTPClientError>
}
