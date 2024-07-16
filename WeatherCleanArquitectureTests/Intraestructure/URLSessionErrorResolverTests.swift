//
//  URLSessionErrorResolverTests.swift
//  WeatherCleanArquitectureTests
//
//  Created by Edgar Guitian Rey on 15/7/24.
//

import Testing
@testable import WeatherCleanArquitecture
import Foundation

@Suite("Infraestructure URLSessionErrorResolver Tests", .tags(.infraestructure))
struct URLSessionErrorResolverTests {

    var errorResolver: URLSessionErrorResolver = URLSessionErrorResolver()

    @Test func resolve_statusCode_tooManyRequests() async throws {
        #expect(errorResolver.resolve(statusCode: 429) == .tooManyRequests)
    }

    @Test func resolve_statusCode_clientError() async throws {
        #expect(errorResolver.resolve(statusCode: 400) == .clientError)
        #expect(errorResolver.resolve(statusCode: 404) == .clientError)
    }

    @Test func resolve_statusCode_serverError() async throws {
        #expect(errorResolver.resolve(statusCode: 500) == .serverError)
        #expect(errorResolver.resolve(statusCode: 503) == .serverError)
    }

    @Test func resolve_error_generic() async throws {
        #expect(errorResolver.resolve(error: NSError(domain: "TestDomain", code: 100, userInfo: nil)) == .generic)
    }

}
