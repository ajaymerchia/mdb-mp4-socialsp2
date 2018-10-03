//
//  Login-animation.swift
//  mdb_mp3_socials
//
//  Created by Ajay Raj Merchia on 9/28/18.
//  Copyright © 2018 Ajay Raj Merchia. All rights reserved.
//

import Foundation
import UIKit

extension LoginViewController {
    
    @objc func revealLogin() {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
            self.advance_to_login.transform = CGAffineTransform(scaleX: 0.75, y: 0.75).concatenating(CGAffineTransform(translationX: 0, y: 80))
            
        }, completion: nil)

        UIView.animate(withDuration: 0.5, delay: 0.5, options: .curveEaseOut, animations: {
            self.username_field.alpha = 1.0
            self.password_field.alpha = 1.0
            
        }, completion: nil)
        
        advance_to_login.removeTarget(self, action: #selector(revealLogin), for: .touchUpInside)
        advance_to_login.addTarget(self, action: #selector(get_email_login), for: .touchUpInside)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if currUsername != nil {
            getFullNameFrom(username: currUsername)
        }
        
        
       
        UIView.animate(withDuration: 1,  delay: 0.5, animations: {() -> Void in
            
            let rotation_angle:CGFloat = 0.8
            let move_distance:CGFloat = 80
            self.socialman[0].transform = CGAffineTransform(rotationAngle: rotation_angle).concatenating(CGAffineTransform(translationX: move_distance, y: 0))
            self.socialman[1].transform = CGAffineTransform(rotationAngle: -rotation_angle).concatenating(CGAffineTransform(translationX: -move_distance, y: 0))

            
        })
    
        
        
    }
}
