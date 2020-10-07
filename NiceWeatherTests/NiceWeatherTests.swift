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
        viewModel = nil
        currentWeather = nil
        lastLocation = nil
        contentView = nil
    }

    func testContentView() {
        let body = contentView.body
        XCTAssertNotNil(body)
    }
    
    func testDateTime() {
        XCTAssertEqual(currentWeather?.datetime, "Wednesday, October 07, 2020 9:27 AM")
    }
    
    func testWeatherDescription() {
        XCTAssertEqual(currentWeather?.weather[0].description, "scattered clouds")
    }

    func testWeatherCity() {
        XCTAssertEqual(currentWeather?.name, "Berlin")
    }
    
    func testWindSpeed() {
        XCTAssertEqual(currentWeather?.wind?.speed, 2.6)
    }
       
    func testWindDirection() {
        XCTAssertEqual(currentWeather?.wind?.deg, 210)
    }
    
    func testWindTemperature() {
        XCTAssertEqual(currentWeather?.main.temp, 12.35)
    }
    
    func testWindTempMin() {
        XCTAssertEqual(currentWeather?.main.tempMin, 11)
    }
    
    func testWindTempMax() {
        XCTAssertEqual(currentWeather?.main.tempMax, 13.89)
    }
    
    func testisDayTime() {
        XCTAssertEqual(viewModel?.isDayTime, true)
    }
    
    func testIcon() {
        XCTAssertEqual(currentWeather?.weather[0].icon, "03d")
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
        viewModel?.currentLocation = Location(city: "Paris", countryCode: "US")
        viewModel?.persistLastLocation()
        XCTAssert(WeatherModel.loadLastLocation() == viewModel?.currentLocation , "location does not persist")
        // restoring previous state
        viewModel?.currentLocation = lastLocation
    }

    func testPerformanceloadLocations() throws {
        // This is an example of a performance test case.
        self.measure {
            _ = WeatherModel.loadLocations()
        }
    }


//    func testExample() throws {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//    }
//
//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
