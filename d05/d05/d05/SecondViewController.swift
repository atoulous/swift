//
//  SecondViewController.swift
//  d05
//
//  Created by Aymeric TOULOUSE on 1/15/18.
//  Copyright © 2018 Aymeric TOULOUSE. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class SecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    var places : [Place] = []
    weak var delegate : LocationProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.places = Place.allPlaces
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "placesCell", for: indexPath) as! PlacesCell
        
        cell.nameLabel.text = places[indexPath.row].name

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let place = Place.allPlaces[indexPath.row]
        let location = CLLocationCoordinate2D(latitude: place.lat, longitude: place.lng)
        delegate?.updateLocation(location: location)
        self.tabBarController!.selectedViewController = self.tabBarController!.viewControllers?[0]
    }

}

protocol LocationProtocol: class {
    func updateLocation(location : CLLocationCoordinate2D)
}
