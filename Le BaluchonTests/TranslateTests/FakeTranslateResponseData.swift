//
//  FakeTranslateReponse.swift
//  Le BaluchonTests
//
//  Created by Sam on 20/07/2022.
//

import Foundation

class FakeTranslateResponseData
{
    static let responseOK = HTTPURLResponse(
        url: URL(string: "https://openclassrooms.com")!,
        statusCode: 200, httpVersion: nil, headerFields: [:])!
    
    static let responseKO = HTTPURLResponse(
        url: URL(string: "https://openclassrooms.com")!,
        statusCode: 500, httpVersion: nil, headerFields: [:])!
    
    class TranslateError: Error {}
    static let error = TranslateError()
    
    static var translateCorrectData: Data
    {
        let bundle = Bundle(for: FakeTranslateResponseData.self)
        let url = bundle.url(forResource: "FakeTranslateResponse", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    static let translateIncorrectData = "erreur".data(using: .utf8)!
}
