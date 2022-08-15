//
//  TranslateApiTests.swift
//  Le BaluchonTests
//
//  Created by Sam on 19/07/2022.
//

import Foundation
import XCTest
@testable import Le_Baluchon

class TranslateApiTestCase: XCTestCase
{
    
    let translateFakeText = "Fake Text here"
    private var translateApi: TranslateApi!
    
    override func setUp()
    {
        super.setUp()
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [URLProtocolFake.self]
        let urlSession = URLSession.init(configuration: configuration)
        translateApi = TranslateApi(session: urlSession)
    }
    
    
    override func tearDown()
    {
        super.tearDown()
        translateApi = nil
    }
    
    func testTranslateApiShouldPostFailWithTranslationIncorrectData()
    {
        // Given
        URLProtocolFake.requestHandler =
        { request in
            let data: Data? = FakeTranslateResponseData.translateIncorrectData
            let response: URLResponse? = FakeTranslateResponseData.responseOK
            let error: Error? = nil
            return (data, response, error)
        }
        // When
        let expectation = XCTestExpectation(description: "wait for change")
        translateApi.fetchTranslation(text: translateFakeText)
        { (result) in
            // Then
            guard case .failure(let error) = result else
            { XCTFail("failure")
                return
            }
            
            XCTAssertNotNil(error)
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    
    func testTranslateApiShouldPostFailedCallbackIfError()
    {
        // Given
        URLProtocolFake.requestHandler =
        { request in
            let data: Data? = FakeTranslateResponseData.translateIncorrectData
            let response: URLResponse? = FakeTranslateResponseData.responseKO
            let error: Error? = nil
            return (data, response, error)
        }
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        translateApi.fetchTranslation(text: translateFakeText)
        { (result) in
            // Then
            guard case .failure(let error) = result else
            { XCTFail("failure")
                return
            }
            
            XCTAssertNotNil(error)
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testTranslateApiShouldPostFailedCallbackIfNoData()
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
        translateApi.fetchTranslation(text: translateFakeText)
        { (result) in
            // Then
            guard case .failure(_) = result else
            { XCTFail("failure")
                return
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testTranslateApiShouldPostSuccessWithCorrectData() {
        // Given
        URLProtocolFake.requestHandler =
        { request in
            let data: Data? = FakeTranslateResponseData.translateCorrectData
            let response: URLResponse? = FakeTranslateResponseData.responseOK
            let error: Error? = nil
            return (data, response, error)
        }
        // When
        let expectation = XCTestExpectation(description: "wait for change")
        
        translateApi.fetchTranslation(text: translateFakeText)
        { (result) in
            // Then
            guard case .success(let translateFrench) = result else
            {
                XCTFail("We shouldn't have a failure")
                return
            }
            
            XCTAssertNotNil(translateFrench.translatedText)
            
            XCTAssertEqual("Does it work ?", translateFrench.translatedText)
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
}
