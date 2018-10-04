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


extension NewSocialViewController: UITextFieldDelegate {
    @objc func locationPicker() {
        let locationPicker = LocationPickerViewController()
        
        locationPicker.showCurrentLocationButton = true
        locationPicker.showCurrentLocationInitially = true
        locationPicker.mapType = .standard
        locationPicker.useCurrentLocationAsHint = true
        locationPicker.resultRegionDistance = 500
        locationPicker.searchBarPlaceholder = "Choose a Location"
        
        locationPicker.completion = { location in
            self.selectedLocation = location?.coordinate
//            self.eventLocationField.text = location?.name
            self.eventLocationButt.setTitle(location?.name, for: .normal)
            self.eventLocationButt.setTitleColor(.black, for: .normal)
        }

        
        navigationController?.pushViewController(locationPicker, animated: true)
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        debugPrint("delegated yeet")
        textField.backgroundColor = rgba(240,240,240,1)
        
        let locationPicker = LocationPickerViewController()
        
        locationPicker.showCurrentLocationButton = true
        locationPicker.showCurrentLocationInitially = true
        locationPicker.mapType = .standard
        locationPicker.useCurrentLocationAsHint = true
        locationPicker.resultRegionDistance = 500
        locationPicker.searchBarPlaceholder = "Choose a Location"
        
        locationPicker.completion = { location in
            self.selectedLocation = location?.coordinate
            self.eventLocationField.text = location?.title
            textField.backgroundColor = .white
        }
//        locationPicker.cancellation = {
//            textField.backgroundColor = .white
//        }
        
        navigationController?.pushViewController(locationPicker, animated: true)
        
        
        return false
    }
}
