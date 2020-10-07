//
//  NiceWeatherSlowTests.swift
//  NiceWeatherSlowTests
//
//  Created by Laurent B on 07/10/2020.
//

import XCTest
@testable import NiceWeather

class NiceWeatherSlowTests: XCTestCase {
    
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
    
//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
