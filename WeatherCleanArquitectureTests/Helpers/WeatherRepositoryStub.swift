//
//  WeatherRepositoryStub.swift
//  WeatherCleanArquitectureTests
//
//  Created by Edgar Guitian Rey on 15/7/24.
//

import Foundation
@testable import WeatherCleanArquitecture

final class WeatherRepositoryStub: WeatherRepositoryType {
    private let result: Result<WeatherResponse, WeatherDomainError>
    
    init(result: Result<WeatherResponse, WeatherDomainError>) {
        self.result = result
    }
    
    func getWeather(city: String) async -> Result<WeatherResponse, WeatherDomainError> {
        return result
    }
}
