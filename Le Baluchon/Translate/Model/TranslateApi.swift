//
//  TranslateApi.swift
//  Le Baluchon
//
//  Created by Sam on 07/07/2022.
//

import Foundation

class TranslateApi
{
    
    // MARK: - Properties
    
    private let session: URLSession
    
    init(session: URLSession = .shared)
    {
        self.session = session
    }
    
    // MARK: - Methods
    
    func fetchTranslation(text: String, callback: @escaping (Result<TranslateModel, Error>) -> Void)
    {
        let request = createTranslationRequest(text: text)
        let task = session.dataTask(with: request)
        { data, response, error in
            DispatchQueue.main.async
            {
                guard let data = data, error == nil else
                {
                    callback(.failure(error!))
                    return
                }
                do
                {
                    let translationResponse = try JSONDecoder().decode(TranslateResponse.self, from: data)
                    let translation = TranslateModel(apiModel: translationResponse)
                    callback(.success(translation))
                } catch
                {
                    callback(.failure(error))
                }
            }
        }
        task.resume()
    }
    
    private func createTranslationRequest(text: String) -> URLRequest
    {
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
