//
//  WeatherAPI.swift
//  Le Baluchon
//
//  Created by Sam on 24/06/2022.
//

import Foundation

class WeatherAPI {
    private var session = URLSession(configuration: .default)

    init(session: URLSession) {
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

    func fetchJSON(city: String, callback: @escaping (Error?, WeatherModel?) -> Void) {
        let request = weatherRequest(city: city)
        let task = session.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(error, nil)
                    return
                }
                do {
                    let responseJSON = try JSONDecoder().decode(WeatherResponse.self, from: data)
                    let weather = WeatherModel(apiModel: responseJSON)
                    callback(nil, weather)
                } catch {
                    callback(error, nil)
                    return
                }
            }
        }
        task.resume()
    }
}

