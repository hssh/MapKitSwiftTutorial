//
//  ViewController.swift
//  MapKitSwiftTutorial
//
//  Created by 小峰央志 on 2014/06/25.
//  Copyright (c) 2014年 hssh. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, UISearchBarDelegate, MKMapViewDelegate {
                            
    @IBOutlet var mapSearchBar: UISearchBar
    @IBOutlet var mapView: MKMapView

    override func viewDidLoad() {
        super.viewDidLoad()

        mapSearchBar.delegate = self
        mapView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(
            mapSearchBar.text,
            completionHandler: {placemarks, error in
                let placemark: CLPlacemark = placemarks[0] as CLPlacemark
                let newLocation = placemark.location.coordinate
        
                let annotation = MKPointAnnotation()
                annotation.setCoordinate(newLocation)
                self.mapView.addAnnotation(annotation)
        
                var mr = self.mapView.visibleMapRect
                let pt = MKMapPointForCoordinate(annotation.coordinate)
                mr.origin.x = pt.x - mr.size.width * 0.5;
                mr.origin.y = pt.y - mr.size.height * 0.25;
                self.mapView.setVisibleMapRect(mr, animated: true)
            }
        )
    }
}

