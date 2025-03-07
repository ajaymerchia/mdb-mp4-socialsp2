//
//  Login-logic.swift
//  mdb_mp3_socials
//
//  Created by Ajay Raj Merchia on 9/27/18.
//  Copyright © 2018 Ajay Raj Merchia. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase
import FirebaseAuth
import JGProgressHUD

extension LoginViewController {
    func connect_buttons() {
        sign_up_button.addTarget(self, action: #selector(go_to_signup), for: .touchUpInside)
    }
    
    @objc func get_email_login() {
        hud = JGProgressHUD(style: .light)
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        
        advance_to_login.isUserInteractionEnabled = false
        guard let username = username_field.text?.lowercased() else {
            self.displayAlert(title: "Oops", message: "Check your username!")
            advance_to_login.isUserInteractionEnabled = true
            return
        }
        if username == "" {
            self.displayAlert(title: "Oops", message: "Check your username!")
            advance_to_login.isUserInteractionEnabled = true
            return
        }
        let ref = Database.database().reference()
        let userRef = ref.child("users").child(username)
        userRef.observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            let email = value?["email"] as? String ?? ""
            let name = value?["fullname"] as? String ?? ""
            
            debugPrint("Got Email: " + email)
            
            self.login_with_email(email: email, usertext: username, fullname: name)
            
            
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    func login_with_email(email: String, usertext: String, fullname: String) {
        advance_to_login.isUserInteractionEnabled = false
        debugPrint("pressed")
        
        
        
        
        guard let password = password_field.text else {
            advance_to_login.isUserInteractionEnabled = true
            self.hud.dismiss()
            return
        }
        
        if password == "" {
            advance_to_login.isUserInteractionEnabled = true
            self.hud.dismiss()
            self.displayAlert(title: "Oops", message: "Check your password!")
            return
        }
    
        
        Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
            if let error = error {
                print(error)
                self.advance_to_login.isUserInteractionEnabled = true
                self.hud.dismiss()
                self.displayAlert(title: "Oops", message: "Check your password!")
                return
            } else {
                self.currUsername = usertext
                self.currFullName = fullname
                self.performSegue(withIdentifier: "login2feed", sender: self)
            }
        })
    }
    
    
    
    func checkForAutoLogin() {
        if let user = Auth.auth().currentUser {
            let ref = Database.database().reference()
            let userRef = ref.child("uid_lookup").child(user.uid)
            userRef.observeSingleEvent(of: .value, with: { (snapshot) in
                // Get user value
                let username = snapshot.value as! String
                
                debugPrint("Got Username: " + username)
                self.currUsername = username
                self.getFullNameFrom(username: username)
                            
            }) { (error) in
                print(error.localizedDescription)
                self.advance_to_login.isUserInteractionEnabled = true
                self.sign_up_button.isUserInteractionEnabled = true
                self.hud?.dismiss()
            }
        } else {
            self.advance_to_login.isUserInteractionEnabled = true
            self.sign_up_button.isUserInteractionEnabled = true
        }
    }
    
    func getFullNameFrom(username: String) {
        let ref = Database.database().reference()
        let userRef = ref.child("users").child(username)
        userRef.observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            let name = value?["fullname"] as? String ?? ""

            self.currFullName = name
            self.currUsername = username
            self.advance_to_login.isUserInteractionEnabled = true            
            self.performSegue(withIdentifier: "login2feed", sender: self)
            // ...
        }) { (error) in
            print(error.localizedDescription)
            self.advance_to_login.isUserInteractionEnabled = true
            self.hud?.dismiss()
        }
    }
    
    @objc func go_to_signup() {
        performSegue(withIdentifier: "login2signup", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "login2feed" {
            LocalData.putLocalData(forKey: .username, data: currUsername)
            LocalData.putLocalData(forKey: .fullname, data: currFullName)
        }
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.hud?.dismiss()
        self.advance_to_login.isUserInteractionEnabled = true
        self.sign_up_button.isUserInteractionEnabled = true

        username_field.text = ""
        password_field.text = ""
    }
    
    func displayAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(defaultAction)
        hud?.dismiss()
        self.present(alert, animated: true, completion: nil)
    }
}
