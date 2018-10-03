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



extension SignUpViewController {
    func connect_buttons() {
        sign_up_button.addTarget(self, action: #selector(attempt_account_creation), for: .touchUpInside)
    }
    
    @objc func attempt_account_creation() {
        sign_up_button.isUserInteractionEnabled = true

        let name = fullname_field.text!
        let username = username_field.text!.lowercased()
        let email = emailadd_field.text!.lowercased()
        let password = password_field.text!
        
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
        
        Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
            if let error = error {
                self.sign_up_button.isUserInteractionEnabled = true
                print(error)
                self.displayAlert(title: "Oops!", message: "Make sure your email is correct and your password is at least 8 characters long.")
                return
            } else {
                guard let uid = user?.user.uid else {
                    return
                }
                let ref = Database.database().reference()
                let userRef = ref.child("users").child(username)
                let values = ["fullname": name, "email": email]
                
                userRef.updateChildValues(values, withCompletionBlock: { (error, ref) in
                    if error != nil {
                        return
                    } else {
                        self.currUsername = username
                        debugPrint("Ready to move on")
                        let origin = self.presentingViewController as? LoginViewController
                        origin?.currUsername = self.currUsername
                        
                        self.dismiss(animated: true, completion: {})
                    }
                })
                
                
                let dataRef = ref.child("uid_lookup")
                dataRef.updateChildValues([uid: username])
                
                
            }
        })
    }
    
    
    
    func signup_error(code: Int) {
        var msg = "We had an issue with "
        switch code {
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
        default:
            msg = msg + " something. Try again later."
        }
        
        displayAlert(title: "Oops", message: msg)
        
    }
    
    
    func displayAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(defaultAction)
        self.present(alert, animated: true, completion: nil)
        sign_up_button.isUserInteractionEnabled = true
        
    }
}
