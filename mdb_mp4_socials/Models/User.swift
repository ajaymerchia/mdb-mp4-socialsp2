//
//  User.swift
//  mdb_mp4_socials
//
//  Created by Ajay Raj Merchia on 10/5/18.
//  Copyright © 2018 Ajay Raj Merchia. All rights reserved.
//

import Foundation
import UIKit
class User {
    var properName: String!
    var email: String!
    var image: UIImage!
    
    init(name: String, email: String, image: UIImage) {
        self.properName = name
        self.email = email
        self.image = image
    }
}
