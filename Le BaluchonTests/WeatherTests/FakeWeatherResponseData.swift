//
//  FakeWeatherResponseData.swift
//  Le BaluchonTests
//
//  Created by Sam on 21/07/2022.
//

import Foundation

class FakeWeatherResponseData
{
    // MARK: - Data
    static var weatherCorrectData: Data? {
        let bundle = Bundle(for: FakeWeatherResponseData.self)
        let url = bundle.url(forResource: "FakeWeatherResponse", withExtension: "json")!
        return try! Data(contentsOf: url)
    }

    static let weatherIncorrectData = "erreur".data(using: .utf8)!

    // MARK: - Response
    static let responseOK = HTTPURLResponse(
        url: URL(string: "https://api.openweathermap.org/")!,
        statusCode: 200, httpVersion: nil, headerFields: [:])!

    static let responseKO = HTTPURLResponse(
        url: URL(string: "https://api.openweathermap.org/")!,
        statusCode: 500, httpVersion: nil, headerFields: [:])!

    // MARK: - Error
    class WeatherError: Error {}
    static let error = WeatherError()
}
