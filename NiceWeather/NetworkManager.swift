//
//  NetworkManager.swift
//  NiceWeather
//
//  Created by Laurent B on 02/10/2020.
//

import UIKit


enum NWError: String, Error {
    case invalidURL    = "This URL string was not valid"
    case unableToComplete   = "Unable to complete your request. Please check your internet connection"
    case invalidResponse    = "Invalid response from the server."
    case invalidData        = "The data received from the server was invalid."
}


class NetworkManager {
    static let shared   = NetworkManager()
    
    // example of my API call
    //http://api.openweathermap.org/data/2.5/weather?q=Berlin,de&APPID=385417c76d45ab1972316b6ffd8b6efa
    
    private let baseURL = "http://api.openweathermap.org/data/2.5/weather?q="
    private let myAPI = "385417c76d45ab1972316b6ffd8b6efa"
    let cache           = NSCache<NSString, UIImage>()
    
    private init() {}
    
    func getWeather(for city: String, country: String, completed: @escaping (Result<CurrentWeather, NWError>) -> Void) {
        let endpoint = baseURL + "\(city),\(country)&APPID=\(myAPI)"
        print(endpoint)
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let response = try decoder.decode(CurrentWeather.self, from: data)
                DispatchQueue.main.async {
                    completed(.success(response))
                }
            } catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
}
