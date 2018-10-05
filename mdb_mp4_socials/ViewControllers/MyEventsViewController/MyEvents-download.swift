//
//  MyEvents-download.swift
//  mdb_mp4_socials
//
//  Created by Ajay Raj Merchia on 10/4/18.
//  Copyright © 2018 Ajay Raj Merchia. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase
import JGProgressHUD

extension MyEventsViewController {
    
    func beginDownloadofEvents() {
        hud = JGProgressHUD(style: .light)
        hud?.textLabel.text = "Loading your Events"
        hud?.show(in: self.view)
        getMyEventKeys()
    }
    
    func getMyEventKeys() {
        guard let username = LocalData.getLocalData(forKey: .username) else {
            return
        }
        
        let userAddress = Database.database().reference().child("users").child(username)
        
        userAddress.observeSingleEvent(of: .value, with: {(snapshot) in
            let userRecord = snapshot.value as? [String : AnyObject] ?? [:]
            var allEventKeys: Set<String> = Set()
            var keySources: [[String: Bool]] = []
            
            
            keySources.append(userRecord["created_events"] as? [String : Bool] ?? [:])
            keySources.append(userRecord["interested_events"] as? [String : Bool] ?? [:])
            
            for source in keySources {
                for (key, active) in source {
                    if active {
                        allEventKeys.insert(key)
                    }
                }
            }
            
//            self.pullFromFirebase(events: Array(allEventKeys))
            self.pullFromFirebaseEfficient(events: Array(allEventKeys))
            

        })
        
    }
    
    func pullFromFirebase(events: [String]){
        let group = DispatchGroup()
        var eventsList: [Event] = []
        
        for eventId in events {
            group.enter()
            let eventRef = Database.database().reference().child("events").child(eventId)
            
            eventRef.observeSingleEvent(of: .value, with: {(snapshot) in
                let eventMap = snapshot.value as? [String : AnyObject] ?? [:]
                
                let event = Event(id: eventId, dict: eventMap)
                event.assignImageEventWith(id: eventId)
                
                eventsList.append(event)
                group.leave()
            })
        }
        
        
        
    }
    
    func pullFromFirebaseEfficient(events: [String]) {
        let group = DispatchGroup()
        var eventsList: [Event] = []
        
        let eventRef = Database.database().reference().child("events")
        
        eventRef.observeSingleEvent(of: .value, with: {(snapshot) in

            let allEvents = snapshot.value as? [String : [String: AnyObject]] ?? [:]
            
            for (eventId, eventMap) in allEvents {
                group.enter()
                if !events.contains(eventId) {
                    group.leave()
                    continue
                }
                
                let event = Event(id: eventId, dict: eventMap)
                event.assignImageEventWith(id: eventId, completion: {
                    eventsList.append(event)
                    group.leave()
                })
                
            }
            
            group.notify(queue: .main, execute: {
                self.pushToTableView(events: eventsList)
            })
            
        })

    }
    
    func pushToTableView(events: [Event]) {
        eventsList = events
        eventsList.sort()
        reload(tableView: socialsList)
        hud?.dismiss()
    }
    
    
    
    
    // LISTENERS
    
    func initEventUpdater() {
        let eventRef = Database.database().reference().child("events")
        eventRef.observe(DataEventType.childChanged, with: { (snapshot) in
            
            debugPrint("child Changed!")
            let newEvent = snapshot.value as? [String : AnyObject] ?? [:]
            
            let e = Event(id: snapshot.key, dict: newEvent)
            guard let name = LocalData.getLocalData(forKey: .fullname) else {
                LocalData.throwCredentialError(self)
                return
            }
            
            if let index = self.eventsList.index(of: e) {
                
                if e.poster != name && !e.interestedMembers.keys.contains(name) {
                    self.socialsList.beginUpdates()
                    self.eventsList.remove(at: index)
                    self.socialsList.deleteRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
                    self.socialsList.endUpdates()

                } else {
                    self.socialsList.setEditing(true, animated: false)
                    let previous_event = self.eventsList[index]
                    e.imageRoute = previous_event.imageRoute
                    e.image = previous_event.image
                    
                    let cell_of_interest = self.socialsList.cellForRow(at: IndexPath(row: index, section: 0)) as? SocialCell
                    cell_of_interest?.initialCellFrom(event: e)
                    self.eventsList[index] = e
                    self.socialsList.setEditing(false, animated: false)

                }

            } else {
                e.assignImageEventWith(id: snapshot.key, completion: {
                    self.eventsList.append(e)
                    self.eventsList.sort()
                    guard let index = self.eventsList.index(of: e) else {
                        return
                    }
                    
                    self.socialsList.beginUpdates()
                    self.socialsList.insertRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
                    self.socialsList.endUpdates()
                })
            }
            
        })
    }
    
}
