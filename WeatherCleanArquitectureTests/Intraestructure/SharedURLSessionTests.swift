//
//  SharedURLSessionTests.swift
//  WeatherCleanArquitectureTests
//
//  Created by Edgar Guitian Rey on 15/7/24.
//

import Testing
@testable import WeatherCleanArquitecture
import Foundation

@Suite("Infraestructure SharedUrlSession Tests", .tags(.infraestructure))
struct SharedURLSessionTests {

    @Test func data_success() async throws {
        // GIVEN
        let url = URL(string: "https://example.com")!
        let request = URLRequest(url: url)
        let sharedSession = SharedURLSession()

        // WHEN
        let (receivedData, receivedResponse) = try await sharedSession.data(for: request)

        // THEN
        #expect(receivedData != nil)
        #expect(receivedResponse != nil)
    }

    @Test func data_failure() async throws {
        // GIVEN
        let url = URL(string: "https://testnotexist.com")!
        let request = URLRequest(url: url)
        let sharedSession = SharedURLSession()

        // WHEN
        let (receivedData, receivedResponse) = try await sharedSession.data(for: request)

        // THEN
        #expect(receivedData == nil)
        #expect(receivedResponse == nil)
    }

}
