//
//  NWError.swift
//  NiceWeather
//
//  Created by Laurent B on 06/10/2020.
//

import Foundation

enum NWError: String, Error {
    case invalidURL    = "This URL string was not valid"
    case unableToComplete   = "Unable to complete your request. Please check your internet connection"
    case invalidResponse    = "Invalid response from the server."
    case invalidData        = "The data received from the server was invalid."
}
