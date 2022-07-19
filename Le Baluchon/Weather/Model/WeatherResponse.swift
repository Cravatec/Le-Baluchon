//
//  WeatherResponse.swift
//  Le Baluchon
//
//  Created by Sam on 07/07/2022.
//

import Foundation

struct WeatherResponse: Decodable
{
    let weather: [Weather]
    let main: Main
    let dt: Double
    let sys: Sys
}

struct Weather: Decodable
{
    let id: Int
    let main: String
}

struct Main: Decodable
{
    let temp: Double
}

struct Sys: Decodable
{
    let sunrise: Double
    let sunset: Double
}
