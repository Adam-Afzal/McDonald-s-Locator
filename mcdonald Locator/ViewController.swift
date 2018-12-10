//
//  ViewController.swift
//  mcdonald Locator
//
//  Created by Kyle on 22/02/2018.
//  Copyright © 2018 Kyle. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var myMapView: MKMapView!
    var locations = [StoreLocation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let span :MKCoordinateSpan = MKCoordinateSpanMake(0.1, 0.1)
        let location :CLLocationCoordinate2D = CLLocationCoordinate2DMake(53.47212, -2.239928)
        let region :MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        
        myMapView.setRegion(region, animated: true)
        myMapView.delegate = self
        // path to data
        let path = Bundle.main.path(forResource: "mcdonalds_data", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        
        // do catch to try read and parse the contents of the data file into an array of StoreLocation objects
        do {
            let data = try Data(contentsOf: url)
            locations = try JSONDecoder().decode([StoreLocation].self, from: data)
        } catch let err {
            print(err)
        }
        
        // Add an annonation for each of the Store Location objects in the location array
        for l in locations {
            // anontations
            /*
            let anontation = MKPointAnnotation()
            anontation.coordinate = CLLocationCoordinate2DMake(Double(l.Latitude), Double(l.Longitude))
            anontation.title = l.StoreName
            anontation.subtitle = l.Street
            myMapView.addAnnotation(anontation)
            */
            let anontation = CustomPins()
            let lat = Double(l.Latitude)
            let lon = Double(l.Longitude)
            anontation.image = UIImage(named: "french-fries")
            anontation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
            anontation.title = l.StoreName
            anontation.subtitle = l.Street + "\n" + l.City + "\n" + l.Postcode
            myMapView.addAnnotation(anontation)
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor anontation: MKAnnotation) -> MKAnnotationView? {
        guard !anontation.isKind(of: MKUserLocation.self) else { return nil }
        let anontationIdentifier = "AnontationIdentifier"
        var anontationView = mapView.dequeueReusableAnnotationView(withIdentifier: anontationIdentifier)
        
        if(anontationView == nil) {
            anontationView = MKAnnotationView(annotation: anontation, reuseIdentifier: anontationIdentifier)
            anontationView!.canShowCallout = true
        }
        else {
            anontationView!.annotation = anontation
        }
        
        let customPointAnontation = anontation as! CustomPins
        anontationView!.image = customPointAnontation.image
        return anontationView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

