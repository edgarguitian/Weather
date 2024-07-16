//
//  URLSessionStub.swift
//  WeatherCleanArquitectureTests
//
//  Created by Edgar Guitian Rey on 16/7/24.
//

import Foundation
@testable import WeatherCleanArquitecture

class URLSessionStub: URLSessionType {
    var dataStub: Data?
    var errorStub: Error?

    func data(for url: URLRequest) async throws -> (Data?, URLResponse?) {
        if let dataStub = dataStub {
            let response = HTTPURLResponse(url: url.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (dataStub, response)
        } else if let errorStub = errorStub {
            throw errorStub
        } else {
            let (data, response) = try await URLSession.shared.data(for: url)
            return (data, response)
        }
    }
}
