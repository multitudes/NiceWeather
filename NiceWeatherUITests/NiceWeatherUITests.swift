//
//  NiceWeatherUITests.swift
//  NiceWeatherUITests
//
//  Created by Laurent B on 02/10/2020.
//

import XCTest

class NiceWeatherUITests: XCTestCase {

    private var app: XCUIApplication!
    
    override func setUp() {
        continueAfterFailure = false
        self.app = XCUIApplication()
        app.launch()
    }
    
    func testDisplayingImages() {
        XCTAssert(app.images.count == 6, "Missing images" )
		XCTAssertTrue(app.buttons["share"].exists)
        XCTAssertTrue(app.images["thermometer"].exists)
        XCTAssertTrue(app.images["current weather icon"].exists)
        XCTAssertTrue(app.images["wind direction"].exists)
        XCTAssertTrue(app.images["wind"].exists)
        XCTAssertTrue(app.images["wind speed animation"].exists)
    }
    
    #if os(iOS)
    func testDisplayingShareButton() {
        XCTAssertTrue(app.buttons["share"].exists)
    }
    #endif
}
