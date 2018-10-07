//
//  LyftRideViewController.swift
//  mdb_mp4_socials
//
//  Created by Ajay Raj Merchia on 10/5/18.
//  Copyright © 2018 Ajay Raj Merchia. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
import LyftSDK

class LyftRideViewController: UIViewController {

    var navbar: UINavigationBar!
    var event: Event!
    var locationDesc: String!
    
    var headerText: UILabel!
    var subtitleText: UILabel!
    var mapView: MKMapView!
    
    let rideTypes: [RideKind] = [.Line, .Standard, .Plus]
    var tierSelectors: [UIButton] = []
    var tierTitles: [UILabel] = []
    var tierPrices: [UILabel] = []
    let tierOptions = ["Line", "Lyft", "Plus"]
    var deepLinkTargets: [String: String] = [:]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initUI()
        APIConnect()
    }
    
}
