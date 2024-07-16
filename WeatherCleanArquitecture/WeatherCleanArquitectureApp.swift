//
//  WeatherCleanArquitectureApp.swift
//  WeatherCleanArquitecture
//
//  Created by Edgar Guitian Rey on 4/1/24.
//

import SwiftUI

@main
struct WeatherCleanArquitectureApp: App {
    var body: some Scene {
        WindowGroup {
            WeatherFactory.create()
        }
    }
}
