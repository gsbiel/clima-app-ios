//
//  WeatherData.swift
//  Clima
//
//  Created by user161182 on 1/8/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

// Esse Model implementa o struct com as partes do objeto JSON, que a API Weather envia para o app, que queremos consumir. Para que aconteca a decodificacao, esse struct deve implementar o protocolo Decodable.
struct WeatherData: Decodable {
    let name : String
    let main : Main
    let weather : [Weather]
}

// Se voce analisar o JSON que API retorna, ele possui um campo main que armazena um objeto com mais propriedades internas, sendo uma delas a propriedade "temp".
// Para podermos decodificar e consumir essa propriedade, temos que representar o objeto mais externo como um struct, que tambem implementa o protocolo Decodable. E dentro desse struct representamos o atributo "temp"
struct Main : Decodable {
    let temp : Double
}

struct Weather : Decodable {
    let description : String
}
