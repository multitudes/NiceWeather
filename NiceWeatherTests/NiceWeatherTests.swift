//
//  NiceWeatherTests.swift
//  NiceWeatherTests
//
//  Created by Laurent B on 02/10/2020.
//

import XCTest
@testable import NiceWeather

class NiceWeatherTests: XCTestCase {

    var viewModel: WeatherModel!
    var currentWeather: CurrentWeather?
    var lastLocation: Location!
    var contentView: ContentView!
    
    override func setUpWithError() throws {
        viewModel = WeatherModel()
        lastLocation = WeatherModel.loadLastLocation()
        contentView = ContentView()
        let data = loadStub(name: "weathertest", extension: "json")
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let weatherData = try decoder.decode(CurrentWeather.self, from: data)
        currentWeather = weatherData
        viewModel.currentLocation = Location(city: "Berlin", countryCode: "De")
        
    }

    override func tearDownWithError() throws {
        // bring back orig state
        viewModel.currentLocation = lastLocation
    }

    func testContentView() {
        let body = contentView.body
        XCTAssertNotNil(body)
    }
    
    func testDateTime() {
        //let 
       // XCTAssertEqual(viewModel.date, "Mon, June 22")
    }
//    func testTitle() {
//        cv = ContentView()
//       // let body = cv?.
//    }


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
