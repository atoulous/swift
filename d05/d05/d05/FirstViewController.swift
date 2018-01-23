//
//  FirstViewController.swift
//  d05
//
//  Created by Aymeric TOULOUSE on 1/15/18.
//  Copyright © 2018 Aymeric TOULOUSE. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class FirstViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, LocationProtocol {

    let locationManager = CLLocationManager()
    var SecondViewController : SecondViewController?
    
    // default 42 location
    var location : CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 48.89649, longitude: 2.31745)
    var mainLocation : CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 48.89649, longitude: 2.31745)
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBAction func centerPos(_ sender: UIButton) {
        let coord = CLLocationCoordinate2D(latitude: mainLocation.latitude, longitude: mainLocation.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: coord, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    @IBAction func controlBar(_ sender: UISegmentedControl) {
        switch (sender.selectedSegmentIndex) {
        case 1:
            mapView.mapType = .satellite
        case 2:
            mapView.mapType = .hybrid
        default:
            mapView.mapType = .standard
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        SecondViewController = (self.tabBarController?.viewControllers?[1] as! SecondViewController?)!
        SecondViewController?.delegate = self

        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 1000

        // zoom && center
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
        
        displayPins(places: Place.allPlaces)
        
    }

    func displayPins(places : [Place]) {
        for place in places {
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: place.lat, longitude: place.lng)
            annotation.title = place.name
            annotation.subtitle = place.subtitle
            mapView.addAnnotation(annotation)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: CLLocationCoordinate2D) {
        self.mainLocation = locations
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var view : MKPinAnnotationView
        
        if let v = mapView.dequeueReusableAnnotationView(withIdentifier: "pin") as? MKPinAnnotationView {
            view = v
        } else {
            view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "pin")
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.pinTintColor = _getRandomColor()
        }

        return view
    }
    
    func updateLocation(location: CLLocationCoordinate2D) {
        self.location = location
        print(location)
        let coord = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.01,longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: coord, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    func _getRandomColor() -> UIColor {
        let randomRed: CGFloat = CGFloat(drand48())
        let randomGreen: CGFloat = CGFloat(drand48())
        let randomBlue: CGFloat = CGFloat(drand48())
        
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    }
}

