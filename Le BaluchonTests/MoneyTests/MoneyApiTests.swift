//
//  MoneyApiTests.swift
//  Le BaluchonTests
//
//  Created by Sam on 21/07/2022.
//

import Foundation
import XCTest
@testable import Le_Baluchon

class MoneyApiTests: XCTestCase
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
        moneyApi = nil
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
        { (result) in
            // Then
            guard case .failure(let error) = result else
            {
                XCTFail("We should have a failure")
                return
            }
            
            XCTAssertNotNil(error)
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testMoneyApiFetchJSONShouldPostSuccessCallbackIfNoErrorAndCorrectData()
    {
        // Given
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
            switch result
            {
            case .success(let moneyModel):
                XCTAssertNotNil(moneyModel)
                XCTAssertNotNil(moneyModel.currencyData)
                let euroRate = moneyModel.currencyData["EUR"]
                XCTAssertNotNil(euroRate)
                XCTAssertEqual(0.975335, euroRate)
            case .failure:
                XCTFail("We should not fail here")
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testMoneyApiShouldPostFailWithError()
    {
        // Given
        URLProtocolFake.requestHandler =
        { request in
            let data: Data? = nil
            let response: URLResponse? = FakeMoneyResponseData.responseKO
            let error: Error? = FakeMoneyResponseData.error
            return (data, response, error)
        }
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        moneyApi.fetchMoney()
        { (result) in
            // Then
            
            guard case .failure(let error) = result else
            {
                XCTFail("We shouldn't have a success case")
                return
            }
            XCTAssertNotNil(error)
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testMoneyApiShouldPostSuccessWithCorrectData()
    {
        // Given
        URLProtocolFake.requestHandler =
        { request in
            let data: Data? = FakeMoneyResponseData.moneyCorrectData
            let response: URLResponse? = FakeMoneyResponseData.responseOK
            let error: Error? = nil
            return (data, response, error)
        }
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        moneyApi.fetchMoney()
        { (result) in
            // Then
            guard case .success(let money) = result else
            {
                return
            }
            
            let rates = ["EUR": 0.975335]
            
            XCTAssertNotNil(rates)
            
            XCTAssertEqual(rates, money.currencyData)
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
}
