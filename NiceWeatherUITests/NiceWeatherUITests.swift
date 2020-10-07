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
        XCTAssert(app.images.count == 5, "Missing images" )
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

//
//    func testLaunchPerformance() throws {
//        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
//            // This measures how long it takes to launch your application.
//            measure(metrics: [XCTApplicationLaunchMetric()]) {
//                XCUIApplication().launch()
//            }
//        }
//    }
}
