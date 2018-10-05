//
//  Detail-map.swift
//  mdb_mp4_socials
//
//  Created by Ajay Raj Merchia on 10/5/18.
//  Copyright © 2018 Ajay Raj Merchia. All rights reserved.
//

import Foundation
import MapKit
import UIKit
import CoreLocation


extension DetailViewController {
    func buildMap(location: CLLocation) {
        let tabY = self.tabBarController!.tabBar.frame.minY
        let mapY = locationInteraction.frame.maxY + marginal_padding/2
        
        let mapView = MKMapView(frame: CGRect(x: left_pad_mult*marginal_padding, y: mapY, width: view.frame.width - 2*left_pad_mult*marginal_padding, height: tabY - mapY - marginal_padding/2))
        mapView.mapType = .standard
        mapView.layer.cornerRadius = 10
        mapView.layer.masksToBounds = true
        mapView.showsUserLocation = true
        mapView.setUserTrackingMode(.follow, animated: true)
        
        mapView.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(openActionSheet)))
        
        
        
//        mapView.isUserLocationVisible = true
        
        annotation = MKPointAnnotation()
        annotation.coordinate = location.coordinate
        mapView.addAnnotation(annotation)
        mapView.setRegion(MKCoordinateRegion(center: annotation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)), animated: true)
        view.addSubview(mapView)
    }
    
    func geocodeAndMap() {
        
//        locationTitle = UILabel())
        
        locationInteraction = UIButton(frame: CGRect(x: left_pad_mult*marginal_padding, y: interestButton.frame.maxY+4*marginal_padding, width: view.frame.width-2*left_pad_mult*marginal_padding, height: 35))
        
        locationInteraction.alpha = 0
        locationInteraction.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        locationInteraction.titleLabel?.adjustsFontSizeToFitWidth = true
        locationInteraction.contentHorizontalAlignment = .left
        locationInteraction.titleLabel?.font = UIFont(name: "Avenir-Roman", size: 16)
        locationInteraction.setTitleColor(.flatSkyBlue, for: .normal)
        locationInteraction.addTarget(self, action: #selector(openActionSheet), for: .touchUpInside)
        
        
        view.addSubview(locationInteraction)
        
        let geocoder = CLGeocoder()
        guard let location = event.location else {
            return
        }
        
        buildMap(location: location)
        
        geocoder.cancelGeocode()
        geocoder.reverseGeocodeLocation(location) { response, error in
            if let error = error as NSError?, error.code != 10 { // ignore cancelGeocode errors
            } else if let placemark = response?.first {
                // get POI name from placemark if any
                debugPrint(placemark)
                let name = placemark.areasOfInterest?.first ?? ("\(placemark.subThoroughfare!) \(placemark.thoroughfare!)")
                self.locationInteraction.setTitle(name, for: .normal)
                self.annotation.title = name
                // pass user selected location too
                UIView.animate(withDuration: 0.5, delay: 0.5, options: .curveEaseOut, animations: {
                    self.locationInteraction.alpha = 1.0
                }, completion: nil)
                
            }
        }
    }
    
    func getDirectionsTo(location: CLLocation) {
        let urlString = "http://maps.apple.com/?saddr=&daddr=\(location.coordinate.latitude),\(location.coordinate.longitude)"
        let url = URL(string: urlString)
        UIApplication.shared.open(url!)
    }
    
    @objc func openActionSheet() {
        let actionSheet = UIAlertController(title: locationInteraction.titleLabel?.text, message: nil, preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Get Directions", style: .default, handler: { (action) -> Void in
            self.getDirectionsTo(location: self.event.location!)
        }))
        actionSheet.addAction(UIAlertAction(title: "Call a Lyft", style: .default, handler: { (action) -> Void in
            self.getDirectionsTo(location: self.event.location!)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true)
        
    }
    
}
