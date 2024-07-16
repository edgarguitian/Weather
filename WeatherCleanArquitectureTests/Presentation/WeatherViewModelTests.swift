//
//  WeatherViewModelTests.swift
//  WeatherCleanArquitectureTests
//
//  Created by Edgar Guitian Rey on 15/7/24.
//

import Testing
@testable import WeatherCleanArquitecture
import Combine
import Foundation
import CombineExpectations

@Suite("Presentation WeatherViewModel Tests", .tags(.presentation))
final class WeatherViewModelTests {

    @Test func init_load() async throws {
        // GIVEN
        let viewModel = WeatherViewModel(getWeather: GetWeatherStub(isSuccess: true),
                                         errorMapper: WeatherPresentableErrorMapper())

        // THEN
        #expect(viewModel.showLoadingSpinner == false)
        #expect(viewModel.showErrorMessage == nil)
        #expect(viewModel.weatherInfo != nil)
        #expect(viewModel.weatherSuccess == false)
    }

    @Test func onAppear_success_when_allUseCases_sucess() async throws {
        // GIVEN
        let viewModel = WeatherViewModel(getWeather: GetWeatherStub(isSuccess: true),
                                         errorMapper: WeatherPresentableErrorMapper())
        
        let weatherInfoRecorder = viewModel.$weatherInfo.record()
        let weatherSuccessRecorder = viewModel.$weatherSuccess.record()
        let showLoadingSpinnerRecorder = viewModel.$showLoadingSpinner.record()

        viewModel.onAppear(city: "")
    
        // THEN
        let weatherInfoValues = try await weatherInfoRecorder.prefix(2).get()
        #expect(viewModel.showLoadingSpinner == false)
        #expect(viewModel.showErrorMessage == nil)
        #expect(viewModel.weatherInfo != nil)
        #expect(viewModel.weatherSuccess == true)

    }

    @Test func onAppear_failure_when_getWeather_fails() async throws {
        // GIVEN
        let viewModel = WeatherViewModel(getWeather: GetWeatherStub(isSuccess: false),
                                         errorMapper: WeatherPresentableErrorMapper())
        
        // WHEN
        let weatherInfoRecorder = viewModel.$weatherInfo.record()
        let weatherSuccessRecorder = viewModel.$weatherSuccess.record()
        let showLoadingSpinnerRecorder = viewModel.$showLoadingSpinner.record()
        let showErrorMessageRecorder = viewModel.$showErrorMessage.record()

        viewModel.onAppear(city: "")

        // THEN
        let showErrorMessageRecorderInfo = try await showErrorMessageRecorder.prefix(2).get()
        #expect(viewModel.showLoadingSpinner == false)
        #expect(viewModel.showErrorMessage != nil)
    }

}
