//
//  ViewController.swift
//  d05
//
//  Created by Aymeric TOULOUSE on 1/15/18.
//  Copyright © 2018 Aymeric TOULOUSE. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

protocol HandleMapSearch {
    func dropPinZoomIn(placemark:MKPlacemark)
}

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    let locationManager = CLLocationManager()
    var resultSearchController : UISearchController?
    var selectedPin: MKPlacemark? = nil
    var swich = 0
    var start: CLLocationCoordinate2D?
    var destination: CLLocationCoordinate2D?
    var searchBar: UISearchBar?
    
    // default 42 location
    var location : CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 48.89649, longitude: 2.31745)
    var mainLocation : CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 48.89649, longitude: 2.31745)
    
    @IBOutlet weak var mapView: MKMapView!

    @IBAction func handleSwitch(_ sender: UIBarButtonItem) {
        switchSwich()
    }
    
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

        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 1000

        // zoom && center
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
        
        //new
        
        let locationSearchTable = storyboard!.instantiateViewController(withIdentifier: "LocationSearchTable") as! LocationSearchTable
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        resultSearchController?.searchResultsUpdater = locationSearchTable

        self.searchBar = resultSearchController!.searchBar
        searchBar?.placeholder = "Start"
        searchBar?.sizeToFit()

        navigationItem.titleView = resultSearchController?.searchBar
        
        resultSearchController?.hidesNavigationBarDuringPresentation = false
        resultSearchController?.dimsBackgroundDuringPresentation = true
        definesPresentationContext = true
    
        locationSearchTable.mapView = mapView
        
        locationSearchTable.handleMapSearchDelegate = self

    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("locationManger, didUpdated")
        self.mainLocation = (locations.first?.coordinate)!
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
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.red
        renderer.lineWidth = 4.0
        
        return renderer
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
    
    func switchSwich() {
        swich = swich == 1 ? 0 : 1
        
        if (swich == 0) {
            searchBar?.placeholder = "Start"
        } else {
            searchBar?.placeholder = "Destination"
        }
    }
}

extension ViewController: HandleMapSearch {
    func dropPinZoomIn(placemark: MKPlacemark){
        selectedPin = placemark
        mapView.removeAnnotations(mapView.annotations)
        let annotation = MKPointAnnotation()
        annotation.coordinate = placemark.coordinate
        annotation.title = placemark.name
        if let city = placemark.locality,
            let state = placemark.administrativeArea {
            annotation.subtitle = "\(city) \(state)"
        }
        mapView.addAnnotation(annotation)
        
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegionMake(placemark.coordinate, span)
        mapView.setRegion(region, animated: true)
        
        self.searchBar?.text = ""

        if self.swich == 0 {
            self.start = placemark.location?.coordinate
            switchSwich()
        } else {
            self.destination = placemark.location?.coordinate
            switchSwich()
        }
        
        if self.destination != nil {
            if self.start == nil {
                self.start = self.mainLocation
            }
            
            let sourceLocation = self.start
            let destinationLocation = self.destination
            
            let sourcePlacemark = MKPlacemark(coordinate: sourceLocation!, addressDictionary: nil)
            let destinationPlacemark = MKPlacemark(coordinate: destinationLocation!, addressDictionary: nil)
            
            let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
            let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
            
            let sourceAnnotation = MKPointAnnotation()
            let destinationAnnotation = MKPointAnnotation()

            if let city = sourcePlacemark.locality,
                let state = sourcePlacemark.administrativeArea {
                sourceAnnotation.subtitle = "\(city) \(state)"
            }
            
            if let city = destinationPlacemark.locality,
                let state = destinationPlacemark.administrativeArea {
                destinationAnnotation.subtitle = "\(city) \(state)"
            }
            
            if let location = sourcePlacemark.location {
                sourceAnnotation.coordinate = location.coordinate
            }
            
            if let location = destinationPlacemark.location {
                destinationAnnotation.coordinate = location.coordinate
            }
            
            self.mapView.showAnnotations([sourceAnnotation, destinationAnnotation], animated: true )
            
            let directionRequest = MKDirectionsRequest()
            directionRequest.source = sourceMapItem
            directionRequest.destination = destinationMapItem
            directionRequest.transportType = .automobile
            
            let directions = MKDirections(request: directionRequest)
            
            self.mapView.removeOverlays(mapView.overlays)
            
            directions.calculate {
                (response, error) -> Void in
                
                guard let response = response else {
                    if let error = error {
                        print("Error: \(error)")
                    }
                    return
                }
                
                let route = response.routes[0]
                self.mapView.add((route.polyline), level: MKOverlayLevel.aboveRoads)
                
                let rect = route.polyline.boundingMapRect
                self.mapView.setRegion(MKCoordinateRegionForMapRect(rect), animated: true)
            }
            
        }
    }
    
    
}

