//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate, WeatherManagerDelegate {

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    var weatherManager = WeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        searchTextField.delegate = self
        weatherManager.delegate = self
    }

    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
        print(searchTextField.text!)
    }
    
    
    // DELEGATE EVENTS! -----------------------------------------------------------------------
    // A variavel interna textField referencia o UITextField que recebeu interacao do usuario!
    func textFieldShouldReturn(_ textField : UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        }
        else {
            textField.placeholder = "Type Something!!!"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let city = searchTextField.text {
            weatherManager.fetchWeather(city)
        }
        textField.text = ""
    }
    
    // Protocolo criado por mim. WeatherManagerDelegate
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel){
        // Quando os dados do clima que foram buscados na API estiverem prontos, essa funcao sera chamada.
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureString
        }
    }
    
    func didFailWithError(error : Error) {
        print(error)
    }
    
    //------------------------------------------------------------------------------------------
    
}

