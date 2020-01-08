//
//  WeatherManager.swift
//  Clima
//
//  Created by user161182 on 1/8/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

let appid = "b637e2f34ebe3de4456fe8f6a71e83cf"

struct WeatherManager {
    
    let weatherURL = "http://api.openweathermap.org/data/2.5/weather?appid=\(appid)&units=metric"
    
    func fetchWeather(_ cityName: String){
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString : String){
        // 1. Criando uma URL
        if let url = URL(string: urlString){
            
            // 2. Criando um URLSession
            let session = URLSession(configuration: .default)
            
            // 3. Designando uma task para a sessao criada
            let task = session.dataTask(with: url, completionHandler: <#T##(Data?, URLResponse?, Error?) -> Void#>)
            
            // 4. Iniciar a task
            task.resume()
            
        }
    }
    
    func handle(data : Data?, response : URLResponse?, error : Error? ){
        
    }
    
}
