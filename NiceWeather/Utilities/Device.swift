//
//  Device.swift
//  NiceWeather
//
//  Created by Laurent B on 06/10/2020.
//

import UIKit

struct Device {
    
    static var name: String {
        struct Singleton {
            static let deviceName = UIDevice.current.name
        }
        return Singleton.deviceName
    }
    
    static var osVersion: String {
        struct Singleton {
            static let deviceVersion = UIDevice.current.systemVersion
        }
        return Singleton.deviceVersion
    }
}
