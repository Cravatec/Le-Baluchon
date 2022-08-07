//
//  FakeWeatherApiTests.swift
//  Le BaluchonTests
//
//  Created by Sam on 21/07/2022.
//

import Foundation
import XCTest
@testable import Le_Baluchon

class FakeWeatherApiTests: XCTestCase
{
    private var weatherApi: WeatherApi!
    
    override func setUp()
    {
        super.setUp()
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [URLProtocolFake.self]
        let urlSession = URLSession.init(configuration: configuration)
        weatherApi = WeatherApi(session: urlSession)
    }
    
    override func tearDown()
    {
        super.tearDown()
    }
    
    func testWeatherServicefetchJSONShouldPostFailedCallbackError()
    {
        // Given
        URLProtocolFake.requestHandler =
        { request in
            let data: Data? = nil
            let response: URLResponse? = nil
            let error: Error? = FakeWeatherResponseData.error
            
            return (data, response, error)
        }
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        
        weatherApi.fetchWeather(city: "Paris")
        { result in
            switch result
            {
            case .success (let error):
                XCTAssertNotNil(error)
            case .failure(let error):
                XCTAssertNotNil(error.localizedDescription)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.01)
    }
}
