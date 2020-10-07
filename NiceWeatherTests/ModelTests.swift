//
//  TestModel.swift
//  NiceWeatherTests
//
//  Created by Laurent B on 06/10/2020.
//

import XCTest
@testable import NiceWeather

class TestModel: XCTestCase {
    
    var sut: WeatherModel?
    
    override func setUp() {
      super.setUp()
      sut = WeatherModel()
    }

    override func tearDown() {
      sut = nil
      super.tearDown()
    }
  
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }



}
