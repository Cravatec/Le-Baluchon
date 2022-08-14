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
    
    func testWeatherApiShouldPostFailWithError()
    {
        // Given
        URLProtocolFake.requestHandler =
        { request in
            let data: Data? = FakeWeatherResponseData.weatherIncorrectData
            let response: URLResponse? = FakeWeatherResponseData.responseKO
            let error: Error? = nil
            
            return (data, response, error)
        }
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        
        weatherApi.fetchWeather(city: "Paris")
        { (result) in
            guard case .failure(let error) = result else { XCTFail("failure")
                return
            }
            
            XCTAssertNotNil(error)
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func testWeatherApiShouldPostFailWithIncorrectData()
    {
        // Given
        URLProtocolFake.requestHandler =
        { request in
            let data: Data? = FakeWeatherResponseData.weatherIncorrectData
            let response: URLResponse? = FakeWeatherResponseData.responseOK
            let error: Error? = nil
            
            return (data, response, error)
        }
        // When
        let expectation = XCTestExpectation(description: "wait for change")
        
        weatherApi.fetchWeather(city: "Paris")
        { (result) in
            guard case .failure(let error) = result else { XCTFail("failure")
                return
            }
            
            XCTAssertNotNil(error)
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testWeatherApiShouldPostSuccessWithNoErrorAndCorrectWeatherData()
    {
        // Given
        URLProtocolFake.requestHandler =
        { request in
            let data: Data? = FakeWeatherResponseData.weatherCorrectData
            let response: URLResponse? = FakeWeatherResponseData.responseOK
            let error: Error? = nil
            
            return (data, response, error)
        }
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        
        weatherApi.fetchWeather(city: "Paris")
        { (result) in
        // Then
            guard case .success(let parisWeather) = result else {
                return
            }
                let main = "Clouds"
                let temp = 20.85
                XCTAssertNotNil(parisWeather)
                XCTAssertEqual(main, parisWeather.main)
                XCTAssertEqual(temp, parisWeather.temperature)
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
}
