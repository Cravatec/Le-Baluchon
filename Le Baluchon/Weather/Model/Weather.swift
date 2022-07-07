//
//  Weather.swift
//  Le Baluchon
//
//  Created by Sam on 24/06/2022.
//

import Foundation

struct WeatherModel {
    // MARK: - Properties
    let conditionId: Int
    let date: Double
    let temperature: Double
    let main: String
    let sunrise: Double
    let sunset: Double

    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
    
    var conditionName: String {
        switch conditionId {
        case 1:
            return "worldwide"
        case 200...232:
            return "thunder"
        case 300...321:
            return "rain"
        case 500...531:
            return  "rain"
        case 600...622:
            return  "sun"
        case 701...781:
            return  "sun"
        case 800:
            if date < sunrise || date > sunset {
                return "moon.stars"
            } else {
                return  "sun.max"}
        case 801...804:
            return  "rain"
        default:
            return "rain"
        }
    }

    // MARK: - Init
    init(apiModel: WeatherResponse) {
        conditionId = apiModel.weather[0].id
        temperature = apiModel.main.temp
        date = apiModel.dt
        main = apiModel.weather[0].main
        sunrise = apiModel.sys.sunrise
        sunset = apiModel.sys.sunset
    }
}
