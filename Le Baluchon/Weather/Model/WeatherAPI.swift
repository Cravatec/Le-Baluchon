//
//  WeatherAPI.swift
//  Le Baluchon
//
//  Created by Sam on 24/06/2022.
//

import Foundation

class WeatherAPI {
    
    static var shared = WeatherAPI()
    private init() {}
    
    private let baseUrl = "https://api.openweathermap.org/data/2.5/weather"
    
    private var task: URLSessionDataTask?
    private let session = URLSession(configuration: .default)
    
    private func buildNYWeatherRequest() -> URLRequest? {
        var urlComponents = URLComponents(string: baseUrl)
        urlComponents?.queryItems = [URLQueryItem(name: "lat", value: NYLocation.latitude),
                                     URLQueryItem(name: "lon", value: NYLocation.longitude)]
        
        if let url = urlComponents?.url {
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "GET"
            urlRequest.addValue(Apikey.weatherApiKey, forHTTPHeaderField: "appid")
            return urlRequest
        }
        return nil
    }
    
    
    func fetchWeather(callback: @escaping (Bool, Weather?) -> Void) {
        guard let request = buildNYWeatherRequest() else {
            return
        }
        
        task = session.dataTask(with: request) { data, response, error in
            
            guard let data = data, error == nil else {
                callback(false, nil)
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                callback(false, nil)
                return
            }
            
            guard let responseJSON = try? JSONDecoder().decode([String: String].self, from: data),
                  let main = responseJSON["main"],
                  let description = responseJSON["description"],
                  let icon = responseJSON["icon"] else {
                callback(false, nil)
                return
            }
            let weather = Weather(main: main, description: description, icon: icon)
            callback(true, weather)
        }
        self.task?.resume()
    }
}


struct NYLocation {
    static let latitude: String = "40.71278"
    static let longitude: String = "-74.005941"
}
