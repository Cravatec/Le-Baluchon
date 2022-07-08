//
//  TranslateApi.swift
//  Le Baluchon
//
//  Created by Sam on 07/07/2022.
//

import Foundation

class TranslateApi {
    // MARK: - Properties
    private var session = URLSession(configuration: .default)
    
    init(session: URLSession) {
        self.session = session
    }
    
    // MARK: - Methods
    func fetchJSON(text: String, callback: @escaping (Error?, TranslateModel?) -> Void) {
        let request = createTranslateRequest(text: text)
        let task = session.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(error, nil)
                    return
                }
                do {
                    let responseJSON = try JSONDecoder().decode(TranslateResponse.self, from: data)
                    let translation = TranslateModel(apiModel: responseJSON)
                    callback(nil, translation)
                } catch {
                    callback(error, nil)
                    return
                }
            }
        }
        task.resume()
    }
    
    private func createTranslateRequest(text: String) -> URLRequest {
        var urlConponents = URLComponents(string: "https://translation.googleapis.com/language/translate/v2")!
        urlConponents.queryItems = [URLQueryItem(name: "q", value: text),
                                    URLQueryItem(name: "key", value: Apikey.translateApiKey),
                                   // URLQueryItem(name: "source", value: "fr"),
                                    URLQueryItem(name: "target", value: "en"),
                                    URLQueryItem(name: "format", value: "text")]
        var request = URLRequest(url: urlConponents.url!)
        request.httpMethod = "GET"
        return request
    }
}
