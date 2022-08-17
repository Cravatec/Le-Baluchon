//
//  FakeMoneyResponseData.swift
//  Le BaluchonTests
//
//  Created by Sam on 21/07/2022.
//

import Foundation

class FakeMoneyResponseData
{
    // MARK: - Data
    static var moneyCorrectData: Data?
    {
        let bundle = Bundle(for: FakeMoneyResponseData.self)
        let url = bundle.url(forResource: "FakeMoneyResponse", withExtension: "json")!
        return try! Data(contentsOf: url)
    }

    static let moneyIncorrectData = "erreur".data(using: .utf8)!

    // MARK: - Response
    static let responseOK = HTTPURLResponse(
        url: URL(string: "https://fixer.io")!,
        statusCode: 200, httpVersion: nil, headerFields: [:])!

    static let responseKO = HTTPURLResponse(
        url: URL(string: "https://fixer.io")!,
        statusCode: 500, httpVersion: nil, headerFields: [:])!

    // MARK: - Error
    class MoneyError: Error {}
    static let error = MoneyError()
}
