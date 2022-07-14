//
//  WeatherAPI.swift
//  Le Baluchon
//
//  Created by Sam on 24/06/2022.
//

import Foundation

class WeatherAPI {
    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session  = session
    }
    
    // MARK: - Methods
    private func weatherRequest(city: String) -> URLRequest {
        let baseUrl = "https://api.openweathermap.org/data/2.5/weather"
        var urlComponents = URLComponents(string: baseUrl)!
        urlComponents.queryItems = [URLQueryItem(name: "q", value: city),
                                    URLQueryItem(name: "units", value: "metric"),
                                    URLQueryItem(name: "appid", value: Apikey.weatherApiKey)]
        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = "GET"
        return request
    }
    
    func fetchWeather(city: String, callback: @escaping (Result<WeatherModel, Error>) -> Void) {
        let request = weatherRequest(city: city)
        let task = session.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                callback(.failure(error!))
                return
            }
            do {
                let weatherResponse = try JSONDecoder().decode(WeatherResponse.self, from: data)
                let weather = WeatherModel(apiModel: weatherResponse)
                callback(.success(weather))
            } catch {
                callback(.failure(error))
            }
        }
        task.resume()
    }
}

