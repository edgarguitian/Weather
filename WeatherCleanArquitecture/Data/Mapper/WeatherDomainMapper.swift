//
//  WeatherDomainMapper.swift
//  WeatherCleanArquitecture
//
//  Created by Edgar Guitian Rey on 4/1/24.
//

import Foundation

class WeatherDomainMapper {
    func map(domain: WeatherResponseDTO) -> WeatherResponse {
        let sunsetWithTimezone = domain.sun.sunset.addingTimeInterval(domain.timezone - Double(TimeZone.current.secondsFromGMT()))
        let sunriseWithTimezone = domain.sun.sunrise.addingTimeInterval(domain.timezone - Double(TimeZone.current.secondsFromGMT()))
        
        return WeatherResponse(city: domain.city,
                               weather: getWeatherDomain(domain),
                               temperature: TemperatureDataModel(currentTemperature: "\(Int(domain.temperature.currentTemperature))º",
                                                                 minTemperature: "\(Int(domain.temperature.minTemperature))º Min.",
                                                                 maxTemperature: "\(Int(domain.temperature.maxTemperature))º Máx.",
                                                                 humidity: "\(domain.temperature.humidity)%"),
                               sun: SunModel(sunrise: sunriseWithTimezone,
                                             sunset: sunsetWithTimezone),
                               timezone: domain.timezone)
    }
    
    func getWeatherDomain(_ domain: WeatherResponseDTO) -> WeatherDataModel {
        guard let weather = domain.weather.first else {
            return .empty
        }
        
        return WeatherDataModel(main: weather.main, description: weather.description, iconURLString: URL(string: "http://openweathermap.org/img/wn/\(weather.iconURLString)@2x.png"))
    }
}
