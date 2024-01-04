//
//  WeatherPresentableErrorMapper.swift
//  WeatherCleanArquitecture
//
//  Created by Edgar Guitian Rey on 4/1/24.
//

import Foundation

class WeatherPresentableErrorMapper {
    func map(error: WeatherDomainError?) -> String {
        guard error == .tooManyRequests else {
            return "Something went wrong"
        }

        return "You have exceeded the limit. Try again later"
    }
}
