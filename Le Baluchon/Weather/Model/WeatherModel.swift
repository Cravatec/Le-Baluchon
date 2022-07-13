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
        return String(format: "%.0f", temperature)
    }
    
    var conditionName: String {
        switch conditionId {
        case 1:
            return "worldwide"
        case 200...232:
            return "thunder"
        case 300...321:
            return "rain_sun"
        case 500...531:
            return  "rain"
        case 600...622:
            return  "snow"
        case 701...781:
            return  "foggy"
        case 800:
            if date < sunrise || date > sunset {
                return "night"
            } else {
                return  "sun"}
        case 801...804:
            return  "clouds"
        default:
            return "sun"
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
