//
//  WeatherFactory.swift
//  WeatherCleanArquitecture
//
//  Created by Edgar Guitian Rey on 4/1/24.
//

import Foundation

class WeatherFactory {
    static func create() -> WeatherView {
        return WeatherView(viewModel: createViewModel())
    }
    
    private static func createViewModel() -> WeatherViewModel {
        return WeatherViewModel(getWeather: createGetWeatherUseCase(),
                                errorMapper: WeatherPresentableErrorMapper())
    }
    
    private static func createGetWeatherUseCase() -> GetWeatherType {
        return GetWeather(repository: createWeatherRepository())
    }
    
    private static func createWeatherRepository() -> WeatherRepository {
        return WeatherRepository(apiDataSource: createAPIDataSource(),
                                 errorMapper: WeatherDomainErrorMapper(),
                                 domainMapper: WeatherDomainMapper())
    }
    
    private static func createAPIDataSource() -> APIWeatherDataSourceType {
        return APIWeatherDataSource(httpClient: createHTTPClient())
    }
    
    private static func createHTTPClient() -> HTTPClient {
        return URLSessionHTTPCLient(requestMaker: URLSessionRequestMaker(),
                                    errorResolver: URLSessionErrorResolver())
    }
}
