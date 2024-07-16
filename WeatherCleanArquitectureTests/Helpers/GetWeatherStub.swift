//
//  GetWeatherStub.swift
//  WeatherCleanArquitectureTests
//
//  Created by Edgar Guitian Rey on 16/7/24.
//

import Foundation
@testable import WeatherCleanArquitecture

final class GetWeatherStub: GetWeatherType {
    private let isSuccess: Bool

    init(isSuccess: Bool) {
        self.isSuccess = isSuccess
    }

    func execute(city: String) async -> Result<WeatherResponse, WeatherDomainError> {
        if isSuccess {
            return .success(WeatherResponse.makeWeatherResponse())
        } else {
            return .failure(WeatherDomainError.generic)
        }
    }
    
    
}
