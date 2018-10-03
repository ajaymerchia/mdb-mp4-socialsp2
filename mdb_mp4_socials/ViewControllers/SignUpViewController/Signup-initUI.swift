//
//  SignUpViewController-initUI.swift
//  mdb_mp3_socials
//
//  Created by Ajay Raj Merchia on 9/27/18.
//  Copyright © 2018 Ajay Raj Merchia. All rights reserved.
//

import Foundation
import UIKit
import ChameleonFramework
import FirebaseDatabase

extension SignUpViewController {
    func initUI() {
        getRestrictedUsernames()
        init_text()
        init_textfield()
        init_buttons()
        initnav()
    }
    
    func init_text() {
        prompt = UILabel(frame: CGRect(x: 0, y: 100, width: view.frame.width, height: 70))
        prompt.textAlignment = .center
        prompt.textColor = UIColor.flatSkyBlueDark
        prompt.font = UIFont(name: "Avenir-Roman", size: 30)
        prompt.text = "Let's get to know you!"
        
        view.addSubview(prompt)
    }
    
    func initnav() {
        let navbar = UINavigationBar(frame: CGRect(x: 0, y: Utils.PADDING, width: view.frame.width, height: 50));
        navbar.tintColor = UIColor.flatSkyBlueDark
        navbar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navbar.shadowImage = UIImage()
        navbar.isTranslucent = true

        self.view.addSubview(navbar)
        
        let navItem = UINavigationItem(title: "")
        let navBarbutton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.stop, target: self, action: #selector(go_back))
        navItem.leftBarButtonItem = navBarbutton
        
        navbar.items = [navItem]
    }
    
    @objc func go_back() {
        self.dismiss(animated: true, completion: {})
    }
    
    
    
    func init_textfield() {
        fullname_field = UITextField(frame: CGRect(x: 2 * Utils.PADDING, y: prompt.frame.maxY+internal_padding, width: view.frame.width - 4 * Utils.PADDING, height: 40))
        
        fullname_field.backgroundColor = UIColor.flatSkyBlueDark
        fullname_field.insetsLayoutMarginsFromSafeArea = true
        fullname_field.textColor = .white
        fullname_field.attributedPlaceholder = NSAttributedString(string: "Full Name",
                                                                  attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        fullname_field.layer.cornerRadius = 5
        fullname_field.textAlignment = .center
        fullname_field.tintColor = .white
        
        
        view.addSubview(fullname_field)
        
        
        emailadd_field = UITextField(frame: CGRect(x: 2 * Utils.PADDING, y: fullname_field.frame.maxY + Utils.PADDING/0.9, width: view.frame.width - 4 * Utils.PADDING, height: 40))
        
        emailadd_field.backgroundColor = UIColor.flatSkyBlueDark
        emailadd_field.insetsLayoutMarginsFromSafeArea = true
        emailadd_field.textColor = .white
        emailadd_field.attributedPlaceholder = NSAttributedString(string: "Email Address",
                                                                  attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        emailadd_field.layer.cornerRadius = 5
        emailadd_field.textAlignment = .center
        emailadd_field.tintColor = .white

        view.addSubview(emailadd_field)
        
        
        username_field = UITextField(frame: CGRect(x: 2 * Utils.PADDING, y: emailadd_field.frame.maxY + Utils.PADDING/0.9, width: view.frame.width - 4 * Utils.PADDING, height: 40))
        
        username_field.backgroundColor = UIColor.flatSkyBlueDark
        username_field.insetsLayoutMarginsFromSafeArea = true
        username_field.textColor = .white
        username_field.attributedPlaceholder = NSAttributedString(string: "Username",
                                                                  attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        username_field.layer.cornerRadius = 5
        username_field.textAlignment = .center
        username_field.tintColor = .white
        view.addSubview(username_field)
        
        
        
        password_field = UITextField(frame: CGRect(x: 2 * Utils.PADDING, y: username_field.frame.maxY + Utils.PADDING/0.9, width: view.frame.width - 4 * Utils.PADDING, height: 40))
        
        password_field.backgroundColor = UIColor.flatSkyBlueDark
        password_field.insetsLayoutMarginsFromSafeArea = true
        password_field.textColor = .white
        password_field.attributedPlaceholder = NSAttributedString(string: "Password",
                                                                  attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        password_field.layer.cornerRadius = 5
        password_field.isSecureTextEntry = true
        password_field.textAlignment = .center
        password_field.tintColor = .white
        view.addSubview(password_field)
    }
    
    func init_buttons() {

        
        sign_up_button = UIButton(frame: CGRect(x: 3.5*Utils.PADDING, y: password_field.frame.maxY + internal_padding, width: view.frame.width - 7*Utils.PADDING, height: 60))
        sign_up_button.setTitle("Sign Up!", for: .normal)
        sign_up_button.titleLabel?.font = UIFont(name: "Avenir-Roman", size: 30)
        sign_up_button.backgroundColor = UIColor.flatSkyBlue
        sign_up_button.layer.cornerRadius = 5

        view.addSubview(sign_up_button)
    }
    
    func getRestrictedUsernames() {
        let ref = Database.database().reference()
        let userRef = ref.child("users")
        userRef.observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            for (name, _) in value ?? [:] {
                if let usrnm = name as? String {
                    self.restrictedUsernames.append(usrnm)
                }
                
            }
            
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
}
