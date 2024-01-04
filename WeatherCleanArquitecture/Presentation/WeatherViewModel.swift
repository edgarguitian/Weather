//
//  WeatherViewModel.swift
//  WeatherCleanArquitecture
//
//  Created by Edgar Guitian Rey on 4/1/24.
//

import Foundation

final class WeatherViewModel: ObservableObject {
    private let getWeather: GetWeatherType
    private let errorMapper: WeatherPresentableErrorMapper
    @Published var showLoadingSpinner: Bool = false
    @Published var showErrorMessage: String?
    @Published var weatherInfo: WeatherResponse
    
    init(getWeather: GetWeatherType, errorMapper: WeatherPresentableErrorMapper) {
        self.getWeather = getWeather
        self.errorMapper = errorMapper
        self.weatherInfo = WeatherResponse()
    }
    
    func onAppear(city: String) {
        Task {
            let result = await getWeather.execute(city: city)
            handleResult(result)
        }
    }
    
    func handleResult(_ result: Result<WeatherResponse, WeatherDomainError>) {
        guard case .success(let weatherInfo) = result else {
            handleError(error: result.failureValue as? WeatherDomainError)
            return
        }
        
        print(weatherInfo)
        Task { @MainActor in
            self.weatherInfo = weatherInfo
            showLoadingSpinner = false
        }
    }
    
    private func handleError(error: WeatherDomainError?) {
        Task { @MainActor in
            showLoadingSpinner = false
            showErrorMessage = errorMapper.map(error: error)
        }
    }
}
