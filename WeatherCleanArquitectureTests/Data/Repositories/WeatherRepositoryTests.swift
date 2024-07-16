//
//  WeatherRepositoryTests.swift
//  WeatherCleanArquitectureTests
//
//  Created by Edgar Guitian Rey on 15/7/24.
//

import Testing
@testable import WeatherCleanArquitecture

@Suite("Data Repositories Weather Repository Tests", .tags(.data))
struct WeatherRepositoryTests {

    @Test func getWeather_returns_success() async throws {
        // GIVEN
        let weatherResponseDTO = WeatherResponseDTO.makeWeatherResponse()
        let mapper = WeatherDomainMapper()
        let expectedResult = mapper.map(domain: weatherResponseDTO)
        let result: Result<WeatherResponseDTO, HTTPClientError> = .success(weatherResponseDTO)
        let apiWeatherStub = APIWeatherDataSourceTypeStub(result: result)
        let sut = WeatherRepository(apiDataSource: apiWeatherStub,
                                    errorMapper: WeatherDomainErrorMapper(),
                                    domainMapper: mapper)

        // WHEN
        let capturedResult = await sut.getWeather(city: "")

        // THEN
        let capturedWeatherResult = try capturedResult.get()
        #expect(capturedWeatherResult == expectedResult)
    }

    @Test func getWeather_returns_failure_when_weatherDataSource_fails() async throws {
        // GIVEN
        let result: Result<WeatherResponseDTO, HTTPClientError> = .failure(.generic)
        let apiWeatherStub = APIWeatherDataSourceTypeStub(result: result)
        let sut = WeatherRepository(apiDataSource: apiWeatherStub,
                                       errorMapper: WeatherDomainErrorMapper(),
                                    domainMapper: WeatherDomainMapper())

        // WHEN
        let capturedResult = await sut.getWeather(city: "")

        // THEN
        guard case .failure(let error) = capturedResult else {
            Issue.record("Expected failure, got success")
            return
        }
        #expect(error == WeatherDomainError.generic)
    }
}
