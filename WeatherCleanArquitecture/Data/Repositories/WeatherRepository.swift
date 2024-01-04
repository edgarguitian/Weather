//
//  WeatherRepository.swift
//  WeatherCleanArquitecture
//
//  Created by Edgar Guitian Rey on 4/1/24.
//

import Foundation

class WeatherRepository: WeatherRepositoryType {
    private let apiDataSource: APIWeatherDataSourceType
    private let errorMapper: WeatherDomainErrorMapper
    private let domainMapper: WeatherDomainMapper
    
    init(apiDataSource: APIWeatherDataSourceType, errorMapper: WeatherDomainErrorMapper, domainMapper: WeatherDomainMapper) {
        self.apiDataSource = apiDataSource
        self.errorMapper = errorMapper
        self.domainMapper = domainMapper
    }
    
    func getWeather(city: String) async -> Result<WeatherResponse, WeatherDomainError> {
        let weatherResponse = await apiDataSource.getWeather(city: city)
        
        guard case .success(let weatherInfo) = weatherResponse else {
            return .failure(errorMapper.map(error: weatherResponse.failureValue as? HTTPClientError))
        }
        
        let weatherDomain = domainMapper.map(domain: weatherInfo)
        
        return .success(weatherDomain)

    }
    
    
}
