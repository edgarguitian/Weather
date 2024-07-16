//
//  APIWeatherDataSourceTypeStub.swift
//  WeatherCleanArquitectureTests
//
//  Created by Edgar Guitian Rey on 16/7/24.
//

import Foundation
@testable import WeatherCleanArquitecture

final class APIWeatherDataSourceTypeStub: APIWeatherDataSourceType {
    private let result: Result<WeatherResponseDTO, HTTPClientError>

    init(result: Result<WeatherResponseDTO, HTTPClientError>) {
        self.result = result
    }

    func getWeather(city: String) async -> Result<WeatherResponseDTO, HTTPClientError> {
        result
    }
    
    
}
