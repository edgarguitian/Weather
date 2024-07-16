//
//  APIWeatherDataSource.swift
//  WeatherCleanArquitecture
//
//  Created by Edgar Guitian Rey on 4/1/24.
//

import Foundation

class APIWeatherDataSource: APIWeatherDataSourceType {
    private let httpClient: HTTPClient
    
    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }
    
    func getWeather(city: String) async -> Result<WeatherResponseDTO, HTTPClientError> {
        let queryParameters: [String: Any] = [
            "q": city,
            "appid": "cb06bd6c75a78ffb5a7a891ae30e20c7",
            "units": "metric",
            "lang": "es"
        ]

        let endpoint = Endpoint(path: "data/2.5/weather",
                                queryParameters: queryParameters,
                                body: [:],
                                method: .get)

        let result = await httpClient.makeRequest(endpoint: endpoint, baseUrl: "http://api.openweathermap.org/")

        guard case .success(let data) = result else {
            return .failure(handleError(error: result.failureValue as? HTTPClientError))
        }

        guard let weatherResponse = try? JSONDecoder().decode(WeatherResponseDTO.self, from: data) else {
            return .failure(.parsingError)
        }
        return .success(weatherResponse)
    }
    
    private func handleError(error: HTTPClientError?) -> HTTPClientError {
        guard let error = error else {
            return .generic
        }

        return error
    }
}
