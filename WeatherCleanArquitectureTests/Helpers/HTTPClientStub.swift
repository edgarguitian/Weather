//
//  HTTPClientStub.swift
//  WeatherCleanArquitectureTests
//
//  Created by Edgar Guitian Rey on 16/7/24.
//

import Foundation
@testable import WeatherCleanArquitecture

final class HTTPClientStub: HTTPClient {
    private let result: Result<Data, HTTPClientError>

    init(result: Result<Data, HTTPClientError>) {
        self.result = result
    }

    func makeRequest(endpoint: Endpoint, baseUrl: String) async -> Result<Data, HTTPClientError> {
        return result
    }
}
