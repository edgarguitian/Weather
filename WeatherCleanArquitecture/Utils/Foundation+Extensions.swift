//
//  Foundation+Extensions.swift
//  WeatherCleanArquitecture
//
//  Created by Edgar Guitian Rey on 4/1/24.
//

import Foundation

extension Result {
    var failureValue: Error? {
        switch self {
        case .failure(let error):
            return error
        case .success:
            return nil
        }
    }
}
