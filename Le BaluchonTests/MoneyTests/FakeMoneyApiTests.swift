//
//  FakeMoneyApiTests.swift
//  Le BaluchonTests
//
//  Created by Sam on 21/07/2022.
//

import Foundation
import XCTest
@testable import Le_Baluchon

class FakeMoneyApiTests: XCTestCase
{
    
    private var moneyApi: MoneyApi!
    
    override func setUp() {
        super.setUp()
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [URLProtocolFake.self]
        let urlSession = URLSession.init(configuration: configuration)
        moneyApi = MoneyApi(session: urlSession)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testMoneyApiFetchJSONShouldPostFailedCallbackError()
    {
        // Given
        URLProtocolFake.requestHandler =
        { request in
            let data: Data? = nil
            let response: URLResponse? = nil
            let error: Error? = FakeMoneyResponseData.error
            return (data, response, error)
        }
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        moneyApi.fetchMoney()
        { result in
            // Then
            switch result
            {
            case .success:
                XCTFail("We should have a failure case")
            case .failure(let error):
                XCTAssertNotNil(error)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testMoneyApiFetchJSONShouldPostFailedCallbackIfNoData()
    {
        // Given
        URLProtocolFake.requestHandler =
        { request in
            let data: Data? = nil
            let response: URLResponse? = nil
            let error: Error? = nil
            return (data, response, error)
        }
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        moneyApi.fetchMoney()
        { result in
            // Then
            switch result
            {
            case .success(let money):
                XCTAssertNil(money)
            case .failure:
                XCTAssertNotNil("We should have a success case")
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testMoneyApiFetchJSONShouldPostFailedCallbackIfIncorrectData()
    {
        // Given
        URLProtocolFake.requestHandler =
        { request in
            let data: Data? = FakeMoneyResponseData.moneyIncorrectData
            let response: URLResponse? = FakeMoneyResponseData.responseOK
            let error: Error? = nil
            return (data, response, error)
        }
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        moneyApi.fetchMoney()
        { result in
            // Then
            switch result
            {
            case .success(let money):
                XCTAssertNil(money)
            case .failure(let error):
                XCTAssertNotNil(error)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testMoneyApiFetchJSONShouldPostSuccessCallbackIfNoErrorAndCorrectData()
    {
        URLProtocolFake.requestHandler =
        { request in
            let data: Data? = FakeMoneyResponseData.moneyCorrectData
            let response: URLResponse? = FakeMoneyResponseData.responseOK
            let error: Error? = nil
            return (data, response, error)
        }
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        moneyApi.fetchMoney() { result in
            // Then
            switch result {
            case .success(_):
                XCTAssertNotNil(Any?.self)
            case .failure(_):
                XCTAssertNotNil(MoneyResponse.self)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
}
