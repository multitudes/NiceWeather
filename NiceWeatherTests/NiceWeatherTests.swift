//
//  NiceWeatherTests.swift
//  NiceWeatherTests
//
//  Created by Laurent B on 02/10/2020.
//

import XCTest
@testable import NiceWeather

class NiceWeatherTests: XCTestCase {

    var sut: URLSession!

    override func setUp() {
      super.setUp()
      sut = URLSession(configuration: .default)
    }

    override func tearDown() {
      sut = nil
      super.tearDown()
    }

    func testValidCallToAPIGetsHTTPStatusCode200(){
        let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=Berlin,DE&units=metric&APPID=385417c76d45ab1972316b6ffd8b6efa")
        let promise = expectation(description: "Completion handler invoked")
        var statusCode: Int?
        var responseError: Error?
        let dataTask = sut.dataTask(with: url!) { data, response, error in
            statusCode = (response as? HTTPURLResponse)?.statusCode
            responseError = error
            promise.fulfill()
        }
        dataTask.resume()
        wait(for: [promise], timeout: 5)
        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 200)
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

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
