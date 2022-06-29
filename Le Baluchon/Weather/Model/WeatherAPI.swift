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
    
    private static let weatherNYUrl = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=40.712784&lon=-74.005941&appid=\(Apikey.weatherApiKey)&lang=fr")!
    
  //  private static let weatherParisUrl = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=48.87213&lon=2.33314&appid=\(Apikey.weatherApiKey)&lang=fr")!

    private var task: URLSessionDataTask?
    private var session = URLSession(configuration: .default)

func fetchWeather(callback: @escaping (Bool, Weather?) -> Void) {
        // Request
        var request = URLRequest(url: WeatherAPI.weatherNYUrl)
        // Request Method
        request.httpMethod = "POST"
        
        let session = URLSession(configuration: .default)
        task = session.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
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
}
