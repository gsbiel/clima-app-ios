//
//  WeatherManager.swift
//  Clima
//
//  Created by user161182 on 1/8/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

let appid = "b637e2f34ebe3de4456fe8f6a71e83cf"

protocol WeatherManagerDelegate {
    func didUpdateWeather(weather : WeatherModel)
}

struct WeatherManager {
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=\(appid)&units=metric"
    
    var delegate : WeatherManagerDelegate?
    
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
            // Notacao de clojure!
            let task = session.dataTask(with: url) { (data,response,error) in
                if error != nil {
                    print(error!)
                    return
                }
                else{
                    if let safeData = data {
                        // parseJSON e uma funcao da classe WeatherManager e esta sendo invocada dentro de um clojure. Nessa situacao temos que explicitamente dizer que o metodo parseJSON pertence a essa classe.
                        if let weather = self.parseJSON(weatherData: safeData) {
                            self.delegate?.didUpdateWeather(weather: weather)
                        }
                    }
                }
            }
            // 4. Iniciar a task
            task.resume()
            
        }
    }
    
    func parseJSON(weatherData : Data) -> WeatherModel? {
        // Criamos a instancia de um decodificador JSON
        let decoder = JSONDecoder()
        do{
            // Decodificamos o JSON que esta em weatherData, que e do tipo Data.
            // A decodificacao acontece em cima de um struc que implemente o protocolo "Decode"
            // Se tudo der certo, o metodo decode vai criar uma instancia do struct com seus atributos preenchidos com os respectivos dados retirados do JSON weatherData.
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            
            return weather
            
        }catch {
            print(error)
            return nil
        }
    }
    
    
}
