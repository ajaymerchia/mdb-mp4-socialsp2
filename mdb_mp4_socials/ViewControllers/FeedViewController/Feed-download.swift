//
//  Feed-download.swift
//  mdb_mp3_socials
//
//  Created by Ajay Raj Merchia on 9/28/18.
//  Copyright © 2018 Ajay Raj Merchia. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase
import FirebaseStorage

extension FeedViewController {
    
    /// Deprecated: View Loader not working as desired
    
    func initEventUpdater() {
        let eventRef = Database.database().reference().child("events")
        eventRef.observe(DataEventType.childChanged, with: { (snapshot) in
            let newEvent = snapshot.value as? [String : AnyObject] ?? [:]
            
            debugPrint("Got some new events YEET")
            debugPrint(newEvent)
            
            let e = Event(id: snapshot.key, dict: newEvent)
            
            if let index = self.eventsList.index(of: e) {
                let previous_event = self.eventsList[index]
                e.imageRoute = previous_event.imageRoute
                e.image = previous_event.image
                
                self.socialsList.setEditing(true, animated: false)
                let cell_of_interest = self.socialsList.cellForRow(at: IndexPath(row: index, section: 0)) as? SocialCell
                cell_of_interest?.initialCellFrom(event: e)
                self.socialsList.setEditing(false, animated: false)

                self.eventsList[index] = e
            }
            
        })
        
    }
    
    func addEventToListAndAnimate(_ event: Event) {
        eventsList.append(event)
        eventsList.sort()
        
        if let insertHere = eventsList.index(of: event) {
            socialsList.beginUpdates()
            socialsList.insertRows(at: [
                IndexPath(row: insertHere, section: 0)
                ], with: .automatic)
            socialsList.endUpdates()
        }
        
    }
    
    func newEventListener() {
        let eventRef = Database.database().reference().child("events")
        eventRef.observe(DataEventType.childAdded, with: { (snapshot) in
            let newEvent = snapshot.value as? [String : AnyObject] ?? [:]
            
            
            let e = Event(id: snapshot.key, dict: newEvent)
            
            if self.eventsList.contains(e) {
                return
            }
            
            e.assignImageEventWith(id: snapshot.key, completion: {
                self.addEventToListAndAnimate(e)
            })
            
            
        })
        
    }
    
    
}
