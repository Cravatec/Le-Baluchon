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
    func testMoneyApiFetchJSONShouldPostFailedCallbackError() {
        // Given
        let moneyApi = MoneyApi(
            session: URLSessionFake(data: nil, response: nil, error: FakeMoneyResponseData.error))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        moneyApi.fetchMoney() { result in
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

    func testMoneyApiFetchJSONShouldPostFailedCallbackIfNoData() {
        // Given
        let moneyApi = MoneyApi(
            session: URLSessionFake(data: nil, response: nil, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        moneyApi.fetchMoney() { result in
            // Then
            switch result {
            case .success(let money):
            XCTAssertNil(money)
            case .failure:
            XCTAssertNil("We should have a success case")
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testMoneyApiFetchJSONShouldPostFailedCallbackIfIncorrectData() {
        // Given
        let moneyApi = MoneyApi(
            session: URLSessionFake(data: FakeMoneyResponseData.moneyIncorrectData,
                                    response: FakeMoneyResponseData.responseOK, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        moneyApi.fetchMoney() { result in
            // Then
            switch result {
            case .success(let money):
            XCTAssertNil(money)
            case .failure(let error):
            XCTAssertNotNil(error)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

//    func testMoneyApiFetchJSONShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
//        let moneyApi = MoneyApi(
//            session: URLSessionFake(data: FakeMoneyResponseData.moneyCorrectData,
//                                    response: FakeMoneyResponseData.responseOK, error: nil))
//        // When
//        let expectation = XCTestExpectation(description: "Wait for queue change")
//        moneyApi.fetchMoney() { result in
//            // Then
//            switch result {
//            case .success():
//                XCTAssertNil(Any?.self)
//            case .failure(_):
//                XCTAssertNotNil(MoneyResponse.self)
//            }
//            expectation.fulfill()
//        }
//        wait(for: [expectation], timeout: 0.01)
//    }
}
