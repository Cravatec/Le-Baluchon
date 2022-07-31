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
    
    override func setUp() {
        super.setUp()
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [URLProtocolFake.self]
        let urlSession = URLSession.init(configuration: configuration)
        translateApi = TranslateApi(session: urlSession)
    }
    
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testGetTranslateShouldPostFailedCallbackIfError() {
        // Given
        URLProtocolFake.data = nil
        URLProtocolFake.response = nil
        URLProtocolFake.error = FakeTranslateResponseData.error

//        let translateApi = TranslateApi(session: urlSession)
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        translateApi.fetchTranslation(text: translateFakeText) { result in
            // Then
            switch result {
            case .success:
                XCTFail("We should have a failure case")
            case .failure(let error):
                XCTAssertNotNil(error)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetTranslateShouldPostFailedCallbackIfNoData() {
        // Given
        let translateApi = TranslateApi(session: URLSessionFake(data: nil, response: nil, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        translateApi.fetchTranslation(text: translateFakeText, callback: { result in
            // Then
            switch result {
            case .success(let translation):
                XCTAssertNil(translation)
            case .failure:
                XCTFail("We should have a success case")
            }
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.01)
    }
    
//    func testGetTransaltionShouldPostFailedCallbackIfIncorectResponse() {
//        // Given
//        let translateApi = TranslateApi(session: URLSessionFake(data: FakeTranslateResponseData.translateCorrectData, response: FakeTranslateResponseData.responseKO, error: nil))
//        // When
//        let expectation = XCTestExpectation(description: "Wait for queue change")
//        translateApi.fetchTranslation(text: translateFakeText) { result in
//            // Then
//            switch result
//            {
//            case .success(let translation):
//                XCTAssertNil(translation)
//            case .failure(let error):
//                XCTAssertNotNil(error)
//            }
//            expectation.fulfill()
//        }
//        wait(for: [expectation], timeout: 0.01)
//    }
    
//    func testGetTranslateShouldPostFailedCallbackIfIncorectData() {
//        // Given
//        let translateApi = TranslateApi(session: URLSessionFake(data: FakeTranslateResponseData.translateIncorrectData, response: FakeTranslateResponseData.responseOK, error: nil))
//        // When
//        let expectation = XCTestExpectation(description: "Wait for queue change")
//        translateApi.fetchTranslation(text: translateFakeText) { result in
//            // Then
//            switch result
//            {
//            case .success(let success):
//            XCTAssertFalse(success)
//            case .failure:
//                XCTAssertNil(self.translateFakeText)
//            }
//            expectation.fulfill()
//        }
//        wait(for: [expectation], timeout: 0.01)
//    }
    
//    func testGetTransalteShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
//        // Given
//
//        let translateApi = TranslateApi(session: URLSessionFake(data: FakeTranslateResponseData.translateCorrectData, response: FakeTranslateResponseData.responseOK, error: nil))
//        // When
//        let expectation = XCTestExpectation(description: "Wait for queue change")
//        translateApi.fetchTranslation(text: translateFakeText) { result in
//            // Then
//            switch result
//            {
//            case .success(let success):
//            XCTAssertTrue(success)
//            case .failure(Error):
//            XCTAssertNotNil(translateFakeText)
//            XCTAssertEqual(text, translateFakeText!.text)
//            }
//            expectation.fulfill()
//        }
//        wait(for: [expectation], timeout: 0.01)
//    }
//}
}

extension XCTestCase {
    func runAsyncTest(
        named TranslateApiTestCase: String = #function,
        in file: StaticString = #file,
        at line: UInt = #line,
        withTimeout timeout: TimeInterval = 10,
        test: @escaping () async throws -> Void)
    {
        var thrownError: Error?
        let errorHandler = { thrownError = $0 }
        let expectation = expectation(description: TranslateApiTestCase)
        
        Task
        { do
        {
            try await test()
        } catch
            {
            errorHandler(error)
        }
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: timeout)
        
        if let error = thrownError
        {
            XCTFail(
                "Async error thrown: \(error)",
                file: file,
                line: line)
        }
    }
}
