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
    }
    
    func testGetTranslateShouldPostFailWithTranslationIncorrectData()
    {
        
        URLProtocolFake.requestHandler =
        { request in
            let data: Data? = FakeTranslateResponseData.translateIncorrectData
            let response: URLResponse? = FakeTranslateResponseData.responseOK
            let error: Error? = nil
            return (data, response, error)
        }
        
        let expectation = XCTestExpectation(description: "wait for change")
        
        translateApi.fetchTranslation(text: translateFakeText) { (result) in
            print(result)
            guard case .failure(let error) = result else { XCTFail("failure")
                return
            }
            XCTAssertNotNil(error)
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    
    func testGetTranslateShouldPostFailedCallbackIfError()
    {
        // Given
        URLProtocolFake.requestHandler =
        { request in
            let data: Data? = nil
            let response: URLResponse? = nil
            let error: Error? = FakeTranslateResponseData.error
            return (data, response, error)
        }
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        
        translateApi.fetchTranslation(text: translateFakeText)
        { (result) in
            print(result)
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
    
    func testGetTranslateShouldPostFailedCallbackIfNoData()
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
            print(result)
            guard case .failure(_) = result else
            { XCTFail("failure")
                return
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
}

//extension XCTestCase {
//    func runAsyncTest(
//        named TranslateApiTestCase: String = #function,
//        in file: StaticString = #file,
//        at line: UInt = #line,
//        withTimeout timeout: TimeInterval = 10,
//        test: @escaping () async throws -> Void)
//    {
//        var thrownError: Error?
//        let errorHandler = { thrownError = $0 }
//        let expectation = expectation(description: TranslateApiTestCase)
//
//        Task
//        { do
//        {
//            try await test()
//        } catch
//            {
//            errorHandler(error)
//        }
//
//            expectation.fulfill()
//        }
//
//        waitForExpectations(timeout: timeout)
//
//        if let error = thrownError
//        {
//            XCTFail(
//                "Async error thrown: \(error)",
//                file: file,
//                line: line)
//        }
//    }
//}
