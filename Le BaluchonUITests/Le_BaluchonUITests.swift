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
    var englishTextViewLabel: XCUIElement {
        app.textViews["EnglishTextView"]
    }
    
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
    
    func testWeatherReloadButton() throws
    {
        // UI tests must launch the application that they test.
        app.tabBars["Tab Bar"].buttons["Weather"].tap()
        app/*@START_MENU_TOKEN@*/.staticTexts["Reload"]/*[[".buttons[\"Reload\"].staticTexts[\"Reload\"]",".staticTexts[\"Reload\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
    }
    
    func testTranslateSender()
    {
        // UI tests must launch the application that they test.
                
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
    }
    
    func testNavBar() {
        app.tabBars["Tab Bar"].buttons["Translate"].tap()
        app.tabBars["Tab Bar"].buttons["Weather"].tap()
        app.tabBars["Tab Bar"].buttons["Money"].tap()
    }
}
