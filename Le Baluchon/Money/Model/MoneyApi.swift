//
//  MoneyAPI.swift
//  Le Baluchon
//
//  Created by Sam on 09/07/2022.
//

import Foundation

class MoneyApi {
    
    // MARK: - Properties
    private let session: URLSession

    init(session: URLSession = .shared)
    {
        self.session  = session
    }
    
    // MARK: - Methods

    private func moneyRequest() -> URLRequest
    {
        var urlConponents = URLComponents(string: "https://api.apilayer.com/fixer/latest")!
        urlConponents.queryItems = [URLQueryItem(name: "apikey", value: Apikey.fixerApiKey),
                                    URLQueryItem(name: "base", value: "EUR"),
                                    URLQueryItem(name: "symbols", value: "USD")]
        var request = URLRequest(url: urlConponents.url!)
        request.httpMethod = "GET"
        return request
    }
    
    func fetchMoney(callback: @escaping (Result<MoneyModel, Error>) -> Void)
    {
        let request = moneyRequest()
        let task = session.dataTask(with: request)
        { data, response, error in
            guard let data = data, error == nil else
            {
                callback(.failure(error!))
                return
            }
            do
            {
                let moneyResponse = try JSONDecoder().decode(MoneyResponse.self, from: data)
                let moneyRates = MoneyModel(apiModel: moneyResponse)
                callback(.success(moneyRates))
            } catch
            {
                callback(.failure(error))
            }
        }
        task.resume()
    }
}
