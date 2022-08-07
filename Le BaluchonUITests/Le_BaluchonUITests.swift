//
//  Le_BaluchonUITests.swift
//  Le BaluchonUITests
//
//  Created by Sam on 22/06/2022.
//

import XCTest
@testable import Le_Baluchon

class Le_BaluchonUITests: XCTestCase
{
    var app:XCUIApplication!
    
    override func setUpWithError() throws
    {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        app = XCUIApplication()
        app.launch()
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        XCUIDevice.shared.orientation = .portrait
    }
    
    override func tearDownWithError() throws
    {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws
    {
        // UI tests must launch the application that they test.
        
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
//    func testLaunchPerformance() throws {
//        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
//            // This measures how long it takes to launch your application.
//            measure(metrics: [XCTApplicationLaunchMetric()]) {
//                XCUIApplication().launch()
//            }
//        }
//    }
    
    func testWeatherReloadButton() throws
    {
        // UI tests must launch the application that they test.
        app.tabBars["Tab Bar"].buttons["Weather"].tap()
        app/*@START_MENU_TOKEN@*/.staticTexts["Reload"]/*[[".buttons[\"Reload\"].staticTexts[\"Reload\"]",".staticTexts[\"Reload\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testTranslateSender()
    {
        // UI tests must launch the application that they test.
        
      //  let englishTextViewLabel = app.textViews["EnglishTextView"]
                
        app.tabBars["Tab Bar"].buttons["Translate"].tap()

        let textView = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .textView).element(boundBy: 0)
        textView.tap()
        app/*@START_MENU_TOKEN@*/.keys["B"]/*[[".keyboards.keys[\"B\"]",".keys[\"B\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.keys["o"]/*[[".keyboards.keys[\"o\"]",".keys[\"o\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.keys["n"]/*[[".keyboards.keys[\"n\"]",".keys[\"n\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.keys["j"]/*[[".keyboards.keys[\"j\"]",".keys[\"j\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.keys["o"]/*[[".keyboards.keys[\"o\"]",".keys[\"o\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.keys["u"]/*[[".keyboards.keys[\"u\"]",".keys[\"u\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.keys["r"]/*[[".keyboards.keys[\"r\"]",".keys[\"r\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.buttons["Send"]/*[[".keyboards",".buttons[\"envoyer\"]",".buttons[\"Send\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
//        let exp = expectation(description: "Test after 3 seconds")
//         let result = XCTWaiter.wait(for: [exp], timeout: 3.0)
//         if result == XCTWaiter.Result.timedOut {
//             XCTAssertEqual( "hello", englishTextViewLabel.label)
//         } else {
//             XCTFail("Delay interrupted")
//         }
        
//        app.textFields

        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
    }
    
}
