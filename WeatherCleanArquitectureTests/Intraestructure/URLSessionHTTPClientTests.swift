//
//  URLSessionHTTPClientTests.swift
//  WeatherCleanArquitectureTests
//
//  Created by Edgar Guitian Rey on 15/7/24.
//

import Testing
@testable import WeatherCleanArquitecture
import Foundation

@Suite("Infraestructure URLSessionHTTPClient Tests", .tags(.infraestructure))
final class URLSessionHTTPClientTests {

    var httpClient: URLSessionHTTPCLient!
    var urlSession: URLSessionStub!
    var mockRequestMaker: URLSessionRequestMaker!
    var errorResolver: URLSessionErrorResolver!
    var responseData: Data!
    
    init() async throws {
        urlSession = URLSessionStub()
        mockRequestMaker = URLSessionRequestMaker()
        errorResolver = URLSessionErrorResolver()
        httpClient = URLSessionHTTPCLient(session: urlSession,
                                          requestMaker: mockRequestMaker,
                                          errorResolver: errorResolver)
    }
    
    deinit {
        urlSession = nil
        mockRequestMaker = nil
        errorResolver = nil
        httpClient = nil
    }

    @Test func makeRequest_success() async throws {
        // GIVEN
        let endpoint = Endpoint(path: "/test", queryParameters: ["param": "value"], body: nil, method: .get)
        let baseURL = "https://example.com"
        responseData = "Response Data".data(using: .utf8)!
        urlSession.dataStub = responseData

        // WHEN
        let capturedResult = await httpClient.makeRequest(endpoint: endpoint, baseUrl: baseURL)

        // THEN
        let capturedSessionResult = try capturedResult.get()
        #expect(capturedSessionResult == responseData)
    }

    @Test func makeRequest_failure_clientError() async throws {
        // GIVEN
        let endpoint = Endpoint(path: "/test", queryParameters: ["param": "value"], body: nil, method: .get)
        let baseURL = "https://example.com"

        // WHEN
        let capturedResult = await httpClient.makeRequest(endpoint: endpoint, baseUrl: baseURL)

        // THEN
        guard case .failure(let error) = capturedResult else {
            Issue.record("Expected failure, got success")
            return
        }

        #expect(error == .clientError)
    }

    @Test func makeRequest_failure_generic() async throws {
        // GIVEN
        let endpoint = Endpoint(path: "/test", queryParameters: ["param": "value"], body: nil, method: .get)
        let baseURL = "https://example.com"
        urlSession.errorStub = NSError(domain: "TestDomain", code: 100, userInfo: nil)

        // WHEN
        let capturedResult = await httpClient.makeRequest(endpoint: endpoint, baseUrl: baseURL)

        // THEN
        guard case .failure(let error) = capturedResult else {
            Issue.record("Expected failure, got success")
            return
        }

        #expect(error == .generic)
    }

}
