//
//  MockGetWeather.swift
//  WeatherCleanArquitectureTests
//
//  Created by Edgar Guitian Rey on 16/7/24.
//

import Foundation
@testable import WeatherCleanArquitecture

class MockGetWeather: GetWeatherType {
    var executeStub: ((String) -> Result<WeatherResponse, WeatherDomainError>)!
    var executeWasCalled = false
    var executeCity: String?

    func execute(city: String) async -> Result<WeatherResponse, WeatherDomainError> {
        executeWasCalled = true
        executeCity = city
        return executeStub(city)
    }
}
