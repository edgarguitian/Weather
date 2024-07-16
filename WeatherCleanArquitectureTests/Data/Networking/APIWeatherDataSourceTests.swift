//
//  APIWeatherDataSourceTests.swift
//  WeatherCleanArquitectureTests
//
//  Created by Edgar Guitian Rey on 15/7/24.
//

import Testing
@testable import WeatherCleanArquitecture
import Foundation

@Suite("Data Networking Weather DataSource Tests", .tags(.data))
struct APIWeatherDataSourceTests {

    @Test func getWeather_return_success_when_httpclient_request_success_and_response_is_correct() async throws {
        // GIVEN
        let data = """
            {"coord":{"lon":2.159,"lat":41.3888},"weather":[{"id":801,"main":"mainTest","description":"descriptionTest","icon":"iconTest"}],"base":"stations","main":{"temp":20.0,"feels_like":28.39,"temp_min":0.0,"temp_max":30.0,"pressure":1016,"humidity":3,"sea_level":1016,"grnd_level":1009},"visibility":10000,"wind":{"speed":4.12,"deg":120},"clouds":{"all":20},"dt":1721120680,"sys":{"type":2,"id":18549,"country":"ES","sunrise":1721104309,"sunset":1721157761},"timezone":0.0,"id":3128760,"name":"cityTest","cod":200}
        """.data(using: .utf8)
        let expectedResult = WeatherResponseDTO.makeWeatherResponse()
        let sut = APIWeatherDataSource(httpClient: HTTPClientStub(result: .success(data!)))

        // WHEN
        let capturedResult = await sut.getWeather(city: "")

        // THEN
        let capturedUserResult = try capturedResult.get()
        #expect(capturedUserResult == expectedResult)
    }

    @Test func getWeather_return_success_when_httpclient_request_fail() async throws {
        // GIVEN
        let sut = APIWeatherDataSource(httpClient: HTTPClientStub(result: .failure(.generic)))

        // WHEN
        let capturedResult = await sut.getWeather(city: "")

        // THEN
        guard case .failure(let error) = capturedResult else {
            Issue.record("Expected failure, got success")
            return
        }

        #expect(error == .generic)
    }

    @Test func getWeather_return_success_when_httpclient_request_sucess_and_response_is_not_correct() async throws {
        // GIVEN
        let data = "".data(using: .utf8)
        let sut = APIWeatherDataSource(httpClient: HTTPClientStub(result: .success(data!)))

        // WHEN
        let capturedResult = await sut.getWeather(city: "")

        // THEN
        guard case .failure(let error) = capturedResult else {
            Issue.record("Expected failure, got success")
            return
        }

        #expect(error == .parsingError)
    }

}

extension WeatherResponseDTO {
    static func makeWeatherResponse() -> WeatherResponseDTO {
        return WeatherResponseDTO(city: "cityTest",
                                  weather: [WeatherDataModelDTO(main: "mainTest",
                                                                description: "descriptionTest",
                                                                iconURLString: "iconTest")],
                                  temperature: TemeperatureDataModelDTO(currentTemperature: 20.0,
                                                                        minTemperature: 0.0,
                                                                        maxTemperature: 30.0,
                                                                        humidity: 3),
                                  sun: SunModelDTO(sunrise: Date(timeIntervalSinceReferenceDate: 1721104309),
                                                   sunset: Date(timeIntervalSinceReferenceDate: 1721157761)),
                                  timezone: 0.0)
    }
}
