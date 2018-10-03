//
//  Detail-favoriting.swift
//  mdb_mp3_socials
//
//  Created by Ajay Raj Merchia on 9/28/18.
//  Copyright © 2018 Ajay Raj Merchia. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase

extension DetailViewController {
    
    @objc func updateInterestCount() {
        interestButton.isSelected = !interestButton.isSelected
        
        var delta = 0
        
        if interestButton.isSelected {
            debugPrint("adding interest")
            delta = 1
        } else {
            debugPrint("removing interested")
            delta = -1
        }
        
        updateInterestForEvent(id: event.event_id, amt: delta)
    }
    
    func updateInterestForEvent(id: String, amt: Int) {
        let interestRef = Database.database().reference().child("events").child(id)
        interestRef.observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            guard let value = snapshot.value as? NSDictionary else {
                return
            }
            var count = value["numInterested"] as! Int
            var interested_folks = value["interestedMembers"] as? [String] ?? []
            
            
            let alreadyThere = interested_folks.contains(self.currUser)
            
            if !alreadyThere && amt > 0 {
                interested_folks.append(self.currUser)
                count += amt
            } else if alreadyThere && amt < 0{
                interested_folks.remove(at: interested_folks.index(of: self.currUser)!)
                count += amt
            }

            interestRef.updateChildValues(["numInterested": count, "interestedMembers": interested_folks], withCompletionBlock: { (error, ref) in
                if error != nil {
                    return
                } else {
                    self.num_interested_label.text = "\(count) Interested"
                    self.interested_list.text = "Guest List: " + (interested_folks).joined(separator: ", ")

                }
            })
            
            
        })
    }
}
