//
//  Interested-profiles.swift
//  mdb_mp4_socials
//
//  Created by Ajay Raj Merchia on 10/5/18.
//  Copyright © 2018 Ajay Raj Merchia. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase
import FirebaseStorage
import JGProgressHUD

extension InterestedViewController {
    func getAllUserImages() {
        hud = JGProgressHUD(style: .light)
        hud?.textLabel.text = "Fetching Profiles"
        hud?.show(in: self.view)
        
        debugPrint("getting user images")
        debugPrint(interestList)
        let group = DispatchGroup()
        
        let userParentNode = Database.database().reference().child("users")
        let photoParentNode = Storage.storage().reference().child("profile_images")
        
        for (user, _) in interestList {
            debugPrint("getting user: \(user)")
            group.enter()
            let userNode = userParentNode.child(user)
            userNode.observeSingleEvent(of: .value, with: {(snapshot) in
                let userData = snapshot.value as? [String: Any] ?? [:]
                photoParentNode.child(user).getData(maxSize: 2 * 1024 * 1024, completion: {(data, err) in
                    
                    
                    
                    guard let fullname = userData["fullname"] as? String else {
                        group.leave()
                        return
                    }
                    guard let email = userData["email"] as? String else {
                        group.leave()
                        return
                    }
                    guard let imageData = data else {
                        self.userList.append(User(name: fullname, email: email, image: UIImage(named: "avatar")!))
                        group.leave()
                        return
                    }
                    guard let image = UIImage(data: imageData) else {
                        self.userList.append(User(name: fullname, email: email, image: UIImage(named: "avatar")!))
                        group.leave()
                        return
                    }
                    
                    self.userList.append(User(name: fullname, email: email, image: image))
                    group.leave()
                    
                    
                })
                
            })
        }
        
        group.notify(queue: .main, execute: {
            debugPrint(self.userList)
            self.displayedList.reloadData()
            self.hud?.dismiss()
        })
        
    }
}
