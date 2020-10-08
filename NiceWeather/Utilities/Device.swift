//
//  Device.swift
//  NiceWeather
//
//  Created by Laurent B on 06/10/2020.
//

import UIKit

struct Device {
    // UIDevice.current.userInterfaceIdiom == .pad
    // or UIDevice.current.userInterfaceIdiom == .phone would not work in this case because Catalyst uses the ipad idiom apparently
    static var isiPhone: Bool {
        struct Singleton {
            static let deviceName = UIDevice.current.name
        }
        return Singleton.deviceName.contains("iPhone")
    }
    
    static var isiPad: Bool {
        struct Singleton {
            static let deviceName = UIDevice.current.name
        }
        return Singleton.deviceName.contains("iPad")
    }
    
    static var osVersion: String {
        struct Singleton {
            static let deviceVersion = UIDevice.current.systemVersion
        }
        return Singleton.deviceVersion
    }
}
