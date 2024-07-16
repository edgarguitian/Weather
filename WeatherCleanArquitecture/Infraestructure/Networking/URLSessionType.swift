//
//  URLSessionType.swift
//  WeatherCleanArquitecture
//
//  Created by Edgar Guitian Rey on 16/7/24.
//

import Foundation

protocol URLSessionType {
    func data(for url: URLRequest) async throws -> (Data?, URLResponse?)
}
