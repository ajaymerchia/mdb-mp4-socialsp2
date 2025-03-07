//
//  NewSocial-EventCreate.swift
//  mdb_mp3_socials
//
//  Created by Ajay Raj Merchia on 9/27/18.
//  Copyright © 2018 Ajay Raj Merchia. All rights reserved.
//

import Foundation
import UIKit
import FirebaseStorage
import FirebaseDatabase
import JGProgressHUD
import CoreLocation

extension NewSocialViewController {
    @objc func createTheEvent() {
        createEvent.isUserInteractionEnabled = false
        hud = JGProgressHUD(style: .light)
        hud.textLabel.text = "Creating Event..."
        hud.show(in: self.view)
        
        var event_entry: [String: Any] = [:]
        
        event_entry["title"] = eventNameField.text!
        event_entry["description"] = eventDescField.text!
        event_entry["date"] = eventDateField.date.description
        
        event_entry["poster"] = fullName
        
        event_entry["numInterested"] = 0
        event_entry["interestedMembers"] = []
        
        
        event_entry["location"] = selectedLocation
        
        
        let event_id = String(format:"%02X", eventNameField.text!.hashValue) + String(format: "%02X", Date.init().description.hashValue)
        
        event_entry["id"] = event_id
        
        for (key, value) in event_entry {
            if let str = value as? String {
                if str == "" || str == "Event Description"{
                    displayAlert(title: "Oops", message: "Please fill out the " + key)
                    return
                }
            } else if let loc = value as? [String : CLLocationDegrees] {
                if !(loc.keys.contains("lon") && loc.keys.contains("lat")) {
                    displayAlert(title: "Oops", message: "Please select a location")
                    return
                }
            }
            
        }
        
        
        
        let image_directory = Storage.storage().reference().child("event_images")
        
        let photoRef = image_directory.child(event_id)
        
        guard let photoData = eventImgPicker.imageView?.image?.jpegData(compressionQuality: 0.4) else {
            return
        }

        
        photoRef.putData(photoData, metadata: nil) { (metadata, error) in
            guard metadata != nil else {
                // Uh-oh, an error occurred!
                debugPrint("error1")
                return
            }
            // Metadata contains file metadata such as size, content-type.
            // let size = metadata.size
            // You can also access to download URL after upload.
            self.pushEventObjectToDatabase(object: event_entry)
        }
        
        
    }
    
    func pushEventObjectToDatabase(object: [String: Any]) {
        let ref = Database.database().reference()
        let userRef = ref.child("events").child(object["id"] as! String)
        
        
        userRef.updateChildValues(object, withCompletionBlock: { (error, ref) in
            if error != nil {
                return
            } else {
                self.addEventIdToUser(object["id"] as! String)
            }
        })
    }
    
    func addEventIdToUser(_ e_id: String) {
        let username = LocalData.getLocalData(forKey: .username)
        
        let owned_events = Database.database().reference().child("users").child(username!).child("created_events")
        owned_events.updateChildValues([e_id : true], withCompletionBlock: { (error, ref) in
            if error != nil {
                return
            } else {
                self.dismiss(animated: true, completion: {})
            }
        })
    }
    
    func displayAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(defaultAction)
        self.present(alert, animated: true, completion: nil)
        hud?.dismiss()
        createEvent.isUserInteractionEnabled = true
    }
}


