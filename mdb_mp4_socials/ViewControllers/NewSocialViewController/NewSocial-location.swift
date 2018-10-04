//
//  NewSocial-location.swift
//  mdb_mp4_socials
//
//  Created by Ajay Raj Merchia on 10/3/18.
//  Copyright © 2018 Ajay Raj Merchia. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import LocationPicker


extension NewSocialViewController {
    @objc func locationPicker() {
        let locationPicker = LocationPickerViewController()
        
        locationPicker.showCurrentLocationButton = true
        locationPicker.showCurrentLocationInitially = true
        locationPicker.mapType = .standard
        locationPicker.useCurrentLocationAsHint = true
        locationPicker.resultRegionDistance = 500
        locationPicker.searchBarPlaceholder = "Choose a Location"
        
        locationPicker.completion = { location in
            self.selectedLocation["lat"] = location?.coordinate.latitude
            self.selectedLocation["lon"] = location?.coordinate.longitude
//            self.eventLocationField.text = location?.name
            self.eventLocationButt.setTitle(location?.name, for: .normal)
            self.eventLocationButt.setTitleColor(.black, for: .normal)
        }

        
        navigationController?.pushViewController(locationPicker, animated: true)
    }
}
