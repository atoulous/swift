//
//  Model.swift
//  d05
//
//  Created by Aymeric TOULOUSE on 1/15/18.
//  Copyright © 2018 Aymeric TOULOUSE. All rights reserved.
//

import Foundation

struct Place {
    var name: String
    var lat: Double
    var lng: Double
    var subtitle: String
    
    static let allPlaces = [
        Place(name: "42", lat: 48.89649, lng: 2.31745, subtitle: "school"),
        Place(name: "Home", lat: 48.8889965, lng: 2.3496451, subtitle: "my flat"),
        Place(name: "Tour Eiffel", lat: 48.8583701, lng: 2.2922873, subtitle: "soo pretty"),
        Place(name: "Vouzon", lat: 47.6347116, lng: 1.964553, subtitle: "le bled"),
        Place(name: "Bordeaux", lat: 44.8637226, lng: -0.621246, subtitle: "le chateau"),
        Place(name: "Saint-Malo", lat: 48.6462606, lng: -2.0773415, subtitle: "les ramparts")
    ]
}
