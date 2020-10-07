//
//  XCTestCase+Ext.swift
//  NiceWeather
//
//  Created by Laurent B on 07/10/2020.
//

import XCTest

extension XCTestCase {

    func loadStub(name: String, extension: String) -> Data {
        let bundle = Bundle(for: type(of: self))
        let url = bundle.url(forResource: name, withExtension: `extension`)
        return try! Data(contentsOf: url!)
    }
}