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
    
    func testDefaultLocations() {
        let defaultLocations = WeatherModel.defaultLocations
        XCTAssertNotNil(defaultLocations.count)
    }
    
    func testDefaultLastLocations() {
        let defaultLastLocation = WeatherModel.defaultLastLocation
        XCTAssertNotNil(defaultLastLocation)
    }
    
    func testUserDefaultKeys() {
        XCTAssert(WeatherModel.locationsKey == "Locations", "locationsKey is wrong")
        XCTAssert(WeatherModel.lastLocationKey == "Lastlocation", "lastLocationKey is wrong")
    }
    
    func testloadLastLocationNotNil() {
        XCTAssertNotNil(WeatherModel.loadLastLocation(), "loadLastLocation() gives a nil value")
    }

    func testloadLocations() {
        XCTAssert(WeatherModel.loadLocations().count > 0, "loadLocations() gives an empty array")
    }
    
    func testcurrentLocationPersistence() {
        let lastLocation = WeatherModel.loadLastLocation()
        sut?.currentLocation = Location(city: "Paris", countryCode: "US")
        sut?.persistLastLocation()
        XCTAssert(WeatherModel.loadLastLocation() == sut?.currentLocation , "location does not persist")
        // restoring previous state
        sut?.currentLocation = lastLocation
    }

    
    
    func testPerformanceloadLocations() throws {
        // This is an example of a performance test case.
        self.measure {
            _ = WeatherModel.loadLocations()
        }
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
