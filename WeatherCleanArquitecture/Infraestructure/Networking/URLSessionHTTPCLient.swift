//
//  URLSessionHTTPCLient.swift
//  WeatherCleanArquitecture
//
//  Created by Edgar Guitian Rey on 4/1/24.
//

import Foundation

class URLSessionHTTPCLient: HTTPClient {
    private let session: URLSessionType
    private let requestMaker: URLSessionRequestMaker
    private let errorResolver: URLSessionErrorResolver

    init(session: URLSessionType = SharedURLSession(),
         requestMaker: URLSessionRequestMaker, errorResolver: URLSessionErrorResolver) {
        self.session = session
        self.requestMaker = requestMaker
        self.errorResolver = errorResolver
    }

    func makeRequest(endpoint: Endpoint, baseUrl: String) async -> Result<Data, HTTPClientError> {
        guard let url = requestMaker.urlRequest(endpoint: endpoint, baseUrl: baseUrl) else {
            return .failure(.badURL)
        }

        do {
            let resultSession = try await session.data(for: url)
            guard let resultData = resultSession.0 else {
                return .failure(.badURL)
            }
            let responseString = String(decoding: resultData, as: UTF8.self)
            print("📗", responseString)
            guard let response = resultSession.1 as? HTTPURLResponse else {
                return .failure(.responseError)
            }

            guard response.statusCode == 200 else {
                return .failure(errorResolver.resolve(statusCode: response.statusCode))
            }

            return .success(resultData)

        } catch {
            return .failure(errorResolver.resolve(error: error))
        }
    }
}
