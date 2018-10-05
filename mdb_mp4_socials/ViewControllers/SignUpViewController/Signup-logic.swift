//
//  Signup-logic.swift
//  mdb_mp3_socials
//
//  Created by Ajay Raj Merchia on 9/27/18.
//  Copyright © 2018 Ajay Raj Merchia. All rights reserved.
//

import Foundation
import FirebaseCore
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage
import JGProgressHUD


extension SignUpViewController {
    func connect_buttons() {
        sign_up_button.addTarget(self, action: #selector(attempt_account_creation), for: .touchUpInside)
    }
    
    @objc func attempt_account_creation() {
        sign_up_button.isUserInteractionEnabled = false
        hud = JGProgressHUD(style: .light)
        hud.textLabel.text = "Creating Account..."
        hud.show(in: self.view)
        
        let name = fullname_field.text!
        let username = username_field.text!.lowercased()
        let email = emailadd_field.text!.lowercased()
        let password = password_field.text!
        
        guard let profilePic = profile_img_button.imageView?.image else {
            signup_error(code: 0)
            return
        }
        
        guard profilePic != UIImage(named: "avatar") else {
            signup_error(code: 0)
            return
        }
        guard name != "" else {
            signup_error(code: 1)
            return
        }
        guard email != "" else {
            signup_error(code: 2)
            return
        }
        guard username != "" else {
            signup_error(code: 3)
            return
        }
        guard password != "" else {
            signup_error(code: 4)
            return
        }
        
        if restrictedUsernames.contains(username.lowercased()) {
            signup_error(code: 5)
            return
        }
        
        let user_record = ["name": name, "email": email, "username": username, "password": password]
        
        uploadProfileImageFor(user: user_record, withImage: profilePic)
    }
    
    func uploadProfileImageFor(user: [String: String], withImage: UIImage) {
        let image_directory = Storage.storage().reference().child("profile_images")
        let photoRef = image_directory.child(user["username"]!)
        guard let photoData = withImage.jpegData(compressionQuality: 0.4) else {
            return
        }
        
        photoRef.putData(photoData, metadata: nil) { (metadata, error) in
            guard metadata != nil else {
                // Uh-oh, an error occurred!
                debugPrint("error1")
                self.signup_error(code: -1)
                return
            }
            // Metadata contains file metadata such as size, content-type.
            // let size = metadata.size
            // You can also access to download URL after upload.
            photoRef.downloadURL { (url, error) in
                guard url != nil else {
                    // Uh-oh, an error occurred!
                    debugPrint("error2")
                    self.signup_error(code: -1)
                    return
                }
                self.createAccountFor(userRecord: user, photo: url!)
            }
        }
    }
    
    func deletePhoto(_ usr: String) {
        let image_directory = Storage.storage().reference().child("profile_images").child(usr)
        image_directory.delete()
    }
    
    func createAccountFor(userRecord: [String: String], photo: URL) {
        let email = userRecord["email"]!
        let password = userRecord["password"]!
        let username = userRecord["username"]!
        let name = userRecord["name"]!
        
        Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
            if let error = error {
                print(error)
                self.signup_error(code: 6)
                self.deletePhoto(username)
                return
            } else {
                guard let uid = user?.user.uid else {
                    return
                }
                let ref = Database.database().reference()
                let userRef = ref.child("users").child(username)
                let values = ["fullname": name, "email": email, "url": photo.absoluteString]
                
                let dataRef = ref.child("uid_lookup")
                dataRef.updateChildValues([uid: username])
                
                userRef.updateChildValues(values, withCompletionBlock: { (error, ref) in
                    
                    LocalData.putLocalData(forKey: .username, data: username)
                    LocalData.putLocalData(forKey: .fullname, data: name)
                    
                    self.dismiss(animated: true, completion: {})
                })
            }
        })
    }
    
    
    
    func signup_error(code: Int) {
        var msg = "We had an issue with "
        switch code {
        case 0:
            msg = msg + "your profile picture."
        case 1:
            msg = msg + "your full name."
        case 2:
            msg = msg + "your email address."
        case 3:
            msg = msg + "your username."
        case 4:
            msg = msg + "your password."
        case 5:
            msg = "Sorry! That username is already taken."
        case 6:
            msg = "Make sure your email is correct and your password is at least 8 characters long."
        default:
            msg = msg + " something. Try again later."
        }
        
        displayAlert(title: "Oops", message: msg)
        sign_up_button.isUserInteractionEnabled = true
        hud?.dismiss()
        
    }
    
    
    func displayAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(defaultAction)
        self.present(alert, animated: true, completion: nil)
        sign_up_button.isUserInteractionEnabled = true
        
    }
}
