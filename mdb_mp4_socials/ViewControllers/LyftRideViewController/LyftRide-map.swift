//
//  LyftRide-map.swift
//  mdb_mp4_socials
//
//  Created by Ajay Raj Merchia on 10/5/18.
//  Copyright © 2018 Ajay Raj Merchia. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import CoreLocation

extension LyftRideViewController: MKMapViewDelegate {
    func initMap(){
        mapView = MKMapView(frame: CGRect(x: Utils.PADDING, y: subtitleText.frame.maxY + Utils.PADDING/2, width: view.frame.width - 2*Utils.PADDING, height: 300))
        mapView.mapType = .standard
        mapView.layer.cornerRadius = 10
        mapView.layer.masksToBounds = true
        mapView.showsUserLocation = true
        mapView.delegate = self
        mapView.setUserTrackingMode(.follow, animated: true)
        
        let destination = MKPointAnnotation()
        destination.coordinate = event.location!.coordinate
        destination.title = locationDesc
        
        mapView.addAnnotation(destination)
        
        
        let source = MKPointAnnotation()
        source.coordinate = mapView.userLocation.coordinate
        
        view.addSubview(mapView)
        
        mapView.showAnnotations([source, destination], animated: true)
        mapView.view(for: source)?.isHidden = true
        
        showRouteOnMap(src: source, des: destination, map: mapView)
        
    }
    
    func showRouteOnMap(src: MKAnnotation, des: MKAnnotation, map: MKMapView) {
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: src.coordinate, addressDictionary: nil))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: des.coordinate, addressDictionary: nil))
        request.requestsAlternateRoutes = true
        request.transportType = .automobile
        
        let directions = MKDirections(request: request)
        
        directions.calculate { response, error in
            guard let unwrappedResponse = response else { return }
            if (unwrappedResponse.routes.count > 0) {
                map.addOverlay(unwrappedResponse.routes[0].polyline)
            }
        }
    }
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let polylineRenderer = MKPolylineRenderer(overlay: overlay)
        polylineRenderer.strokeColor = rgba(0, 88, 230, 0.7)
        polylineRenderer.lineWidth = 5
        return polylineRenderer
    }

}
