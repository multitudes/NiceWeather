//
//  String+Ext.swift
//  NiceWeather
//
//  Created by Laurent B on 04/10/2020.
//

import Foundation

@available (macOS 10.15, * )
extension String {
    subscript(idx: Int) -> String {
        String(self[index(startIndex, offsetBy: idx)])
    }
}
