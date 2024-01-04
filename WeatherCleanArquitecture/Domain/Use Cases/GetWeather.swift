//
//  GetWeather.swift
//  WeatherCleanArquitecture
//
//  Created by Edgar Guitian Rey on 4/1/24.
//

import Foundation

class GetWeather: GetWeatherType {
    private let repository: WeatherRepositoryType
    
    init(repository: WeatherRepositoryType) {
        self.repository = repository
    }
    
    func execute(city: String) async -> Result<WeatherResponse, WeatherDomainError> {
        let result = await repository.getWeather(city: city)
        
        guard let weatherResult = try? result.get() else {
            guard case .failure(let error) = result else {
                return .failure(.generic)
            }

            return .failure(error)
        }
        
        return .success(weatherResult)
    }
}
