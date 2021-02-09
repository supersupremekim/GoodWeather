//
//  Webservice.swift
//  GoodWeather
//
//  Created by 김동환 on 2021/02/09.
//

import Foundation

struct Webservice {
    
    func fetchWether(cityName: String, completion: @escaping ((WeatherModel) -> Void)){
        
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=e61267c07543e45b46ba83f54ac8fb03") else {
            fatalError()
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data, error == nil else {
                fatalError()
            }
            
            guard let decoded = try? JSONDecoder().decode(WeatherModel.self, from: data) else {
                fatalError()
            }
            
            
            DispatchQueue.main.async {
                completion(decoded)
            }
            
        }.resume()
    }
}
