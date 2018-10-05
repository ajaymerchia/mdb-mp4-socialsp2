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
    func download_events() {
        let eventRef = Database.database().reference().child("events")
        let image_directory = Storage.storage().reference().child("event_images")
        
        eventRef.observeSingleEvent(of: .value, with: { (snapshot) in
            let allEvents = snapshot.value as? [String : AnyObject] ?? [:]
            let group = DispatchGroup()
            var recentPull:[Event] = []
            
            
            for (key, value) in allEvents {
                group.enter()
                
                let e = Event(id: key, dict: value as! [String : AnyObject])
                
                if self.save_the_quota {
                    e.imageRoute = "DEFAULT"
                    e.image = UIImage(named: "default_event")
                    recentPull.append(e)
                    group.leave()
                } else {
                    let imageFile = image_directory.child(key)
                    
                    
                    // Download in memory with a maximum allowed size of 5MB (1 * 1024 * 1024 bytes)
                    imageFile.getData(maxSize: 5 * 1024 * 1024) { data, error in
                        if let error = error {
                            // Uh-oh, an error occurred!
                            debugPrint("Error with file retrieve", error)
                            e.imageRoute = "DEFAULT"
                            e.image = UIImage(named: "default_event")
                        } else {
                            e.image = UIImage(data: data!)
                        }
                        debugPrint("adding " + key)
                        recentPull.append(e)
                        group.leave()
                    }
                }
                
            }
            
            group.notify(queue: DispatchQueue.main, execute: {
                debugPrint()
                self.eventsList = recentPull.sorted()
                self.reload(tableView: self.socialsList)
                self.newEventListener()
                self.initEventUpdater()
            })
        })
    }
    
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
        let image_directory = Storage.storage().reference().child("event_images")

        eventRef.observe(DataEventType.childAdded, with: { (snapshot) in
            let newEvent = snapshot.value as? [String : AnyObject] ?? [:]
            
            
            let e = Event(id: snapshot.key, dict: newEvent)
            
            if self.eventsList.contains(e) {
                return
            }
            
            if self.save_the_quota {
                e.imageRoute = "DEFAULT"
                e.image = UIImage(named: "default_event")
                self.addEventToListAndAnimate(e)
            } else {
                let imageFile = image_directory.child(snapshot.key)
                // Download in memory with a maximum allowed size of 5MB (1 * 1024 * 1024 bytes)
                imageFile.getData(maxSize: 5 * 1024 * 1024) { data, error in
                    if let error = error {
                        // Uh-oh, an error occurred!
                        debugPrint("Error with file retrieve", error)
                        e.imageRoute = "DEFAULT"
                        e.image = UIImage(named: "default_event")
                    } else {
                        e.image = UIImage(data: data!)
                    }
                    self.addEventToListAndAnimate(e)
                }
            }
            
        })
        
    }
    
    
}
