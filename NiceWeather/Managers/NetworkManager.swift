//
//  NetworkManager.swift
//  NiceWeather
//
//  Created by Laurent B on 02/10/2020.
//

import UIKit

class NetworkManager {

    static let shared   = NetworkManager()
    
    // example of my API call
    //http://api.openweathermap.org/data/2.5/weather?q=Berlin,DE&units=metric&APPID=385417c76d45ab1972316b6ffd8b6efa
    
    private let baseURL = "http://api.openweathermap.org/data/2.5/weather?q="
    private let myAPI = "385417c76d45ab1972316b6ffd8b6efa"
    let cache           = NSCache<NSString, UIImage>()
	var locale: String {
		if Locale.current.languageCode! == "ko" {
			return "kr"
		} else {
			return Locale.current.languageCode!
		}
	}

    private init() {}
    
    func getWeather(for city: String, country: String, completed: @escaping (Result<CurrentWeather, NWError>) -> Void) {
			  print("region \(Locale.current.regionCode!) languageCode \(Locale.current.languageCode!)")
        let endpoint = baseURL + "\(city),\(country)&units=metric&APPID=\(myAPI)&lang=\(locale)"
        print("endpoint: \(endpoint)")
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
                decoder.dateDecodingStrategy = .secondsSince1970
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
    
    func downloadImage(from icon: String, completed: @escaping (UIImage?) -> Void) {
        let urlString: String = "http://openweathermap.org/img/wn/\(icon)@2x.png"
            print("url: \(urlString)")
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) {
            completed(image)
            print("cache hit!")
            return
        }
        
        guard let url = URL(string: urlString) else {
            completed(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            
            guard let self = self,
                error == nil,
                let response = response as? HTTPURLResponse, response.statusCode == 200,
                let data = data,
                let image = UIImage(data: data) else {
                    print("nil")
                    completed(nil)
                    return
                }
            
            self.cache.setObject(image, forKey: cacheKey)
            print("image set in cache")
            completed(image)
        }
        
        task.resume()
    }

}
