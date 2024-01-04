//
//  WeatherDomainErrorMapper.swift
//  WeatherCleanArquitecture
//
//  Created by Edgar Guitian Rey on 4/1/24.
//

import Foundation

class WeatherDomainErrorMapper {
    func map(error: HTTPClientError?) -> WeatherDomainError {
        guard error == .tooManyRequests else {
            return .generic
        }

        return .tooManyRequests
    }
}
