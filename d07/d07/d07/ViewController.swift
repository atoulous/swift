//
//  ViewController.swift
//  d07
//
//  Created by Aymeric TOULOUSE on 1/17/18.
//  Copyright © 2018 Aymeric TOULOUSE. All rights reserved.
//

import UIKit
import ForecastIO
import RecastAI
import Foundation

class ViewController: UIViewController {

    let darkSkyClient = DarkSkyClient(apiKey: "888bd463454723dc33a54f9c11f03586")
    let recastIOClient = RecastAIClient(token: "67fb736adda3a48065866a63c5bc1f8c")
    
    @IBOutlet weak var textRequestRecast: UITextField!
    @IBOutlet weak var labelTextRecast: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBAction func handleEnter(_ sender: UITextField) {
        handleRequestRecast()
    }
    
    @IBAction func handleButton(_ sender: UIButton) {
        handleRequestRecast()
    }
    
    func handleRequestRecast() {
        if textRequestRecast.text != "" {
            activityIndicator.startAnimating()
            activityIndicator.alpha = 1
            callRecastIO(text: textRequestRecast.text!)
        } else {
            labelTextRecast.text = "Sorry, I don't understand the question."
        }
    }

    func callRecastIO(text: String) {
        recastIOClient.textRequest(text, successHandler: { (res) in
            if res.intent()?.slug == "get-weather" {
                if let location = res.get(entity: "location") {
                    self.getWeatherFromLocal(lat: location["lat"] as! Double, lng: location["lng"] as! Double)
                } else {
                    print("err/location", res)
                    self.labelTextRecast.text = "Sorry, I don't understand the question."
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.alpha = 0
                }
            } else {
                print("err/indent", res)
                DispatchQueue.main.async {
                    self.labelTextRecast.text = "Sorry, I don't understand the question."
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.alpha = 0
                }
            }
        }) { (err) in
            print("err==", err)
        }
    }
    
    func getWeatherFromLocal(lat: Double, lng: Double) {
        darkSkyClient.getForecast(latitude: lat, longitude: lng) { (result) in
            switch result {
            case .success(let forecast, _):
                if let currently = forecast.currently {
                    let weather = currently.summary!
                    let temp = currently.temperature!
                    
                    DispatchQueue.main.async {
                        self.labelTextRecast.text = "The weather is \(weather) and the temperature is \(temp) F."
                        self.activityIndicator.stopAnimating()
                        self.activityIndicator.alpha = 0
                    }
                } else {
                    print("err")
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.alpha = 0
                }
            default:
                print("default==", result)
                self.activityIndicator.stopAnimating()
                self.activityIndicator.alpha = 0
            }
        }
    }

}

