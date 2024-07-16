//
//  GetWeatherTests.swift
//  WeatherCleanArquitectureTests
//
//  Created by Edgar Guitian Rey on 15/7/24.
//

import Testing
@testable import WeatherCleanArquitecture

@Suite("Domain GetWeather Use Case Test", .tags(.domain))
struct GetWeatherTests {

    @Test func execute_succesfully_returns_success() async throws {
        // GIVEN
        let weatherResponse = WeatherResponse.makeWeatherResponse()
        let result: Result<WeatherResponse, WeatherDomainError> = .success(weatherResponse)
        let stub = WeatherRepositoryStub(result: result)
        let sut = GetWeather(repository: stub)
        
        // WHEN
        let capturedResult = await sut.execute(city: "")
        
        // THEN
        let capturedWeatherResult = try capturedResult.get()
        #expect(capturedWeatherResult == weatherResponse)
    }
    
    @Test func execute_returns_error_when_repository_returns_error() async throws {
        // GIVEN
        let result: Result<WeatherResponse, WeatherDomainError> = .failure(.generic)
        let stub = WeatherRepositoryStub(result: result)
        let sut = GetWeather(repository: stub)
        
        // WHEN
        let capturedResult = await sut.execute(city: "")
        
        // THEN
        guard case .failure(let error) = capturedResult else {
            Issue.record("Expected failure, got success")
            return
        }
        #expect(error == .generic)
    }

}

extension WeatherResponse {
    static func makeWeatherResponse() -> WeatherResponse {
        return WeatherResponse(city: "cityTest",
                               weather: WeatherDataModel(main: "mainTest",
                                                         description: "descriptionTest",
                                                         iconURLString: nil),
                               temperature: TemperatureDataModel(currentTemperature: "currentTempTest",
                                                                 minTemperature: "minTempTest",
                                                                 maxTemperature: "maxTempTest",
                                                                 humidity: "humidityTest"),
                               sun: SunModel(sunrise: .now,
                                             sunset: .now),
                               timezone: 0.0)
    }
}
