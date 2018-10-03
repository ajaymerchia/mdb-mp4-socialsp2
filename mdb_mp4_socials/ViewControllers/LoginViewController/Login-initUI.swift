//
//  Login-initUI.swift
//  mdb_mp3_socials
//
//  Created by Ajay Raj Merchia on 9/27/18.
//  Copyright © 2018 Ajay Raj Merchia. All rights reserved.
//

import UIKit
import ChameleonFramework

extension LoginViewController {
    func initUI() {
        init_img()
        init_text()
        init_textfield()
        init_buttons()
        
        
//        automatic_login_fields()
    }
    
    func automatic_login_fields() {
        username_field.text = "A"
        password_field.text = "password123"
    }
    
    func init_img() {
        mdb_logo = UIImageView(frame: CGRect(x: 0, y: 0, width: view.frame.width/2.5, height: view.frame.height/3))
        
        
        let LOGO_WIDTH: CGFloat = 480
        let PHONE_WIDTH: CGFloat = 350
        let CENTER_BIAS = (LOGO_WIDTH-PHONE_WIDTH)/(2*LOGO_WIDTH)
        
        mdb_logo.center = CGPoint(x: view.frame.width/(2-CENTER_BIAS), y: view.frame.height/3.5)
        mdb_logo.image = UIImage(named: "mdb_logo")
        mdb_logo.contentMode = .scaleAspectFit
        view.addSubview(mdb_logo)
        
        let offset:CGFloat = 10
        
        for i in 0...1 {
            socialman.append(UIImageView(frame: CGRect(x: 0, y: 0, width: view.frame.width/4, height: view.frame.width/4)))
            socialman[i].contentMode = .scaleAspectFit
            socialman[i].image = UIImage(named: "socialman")
            socialman[i].center = CGPoint(x: view.frame.width/2 - ((CGFloat(i) - 0.5)*2*offset), y: mdb_logo.frame.midY)
            
            view.insertSubview(socialman[i], at: 0)
            
        }
        
    }
    
    func init_text() {
        socials_header = UILabel(frame: CGRect(x: 0, y: mdb_logo.frame.maxY + 1.5*Utils.PADDING, width: view.frame.width, height: 100))
        socials_header.textAlignment = .center
        
        socials_header.text = "Socials"
        socials_header.textColor = UIColor.flatSkyBlueDark
        socials_header.font = UIFont(name: "Playball-Regular", size: 110)
        
        socials_header.adjustsFontSizeToFitWidth = true

        view.addSubview(socials_header)
        
        mdb_header = UILabel(frame: CGRect(x: 0, y: socials_header.frame.minY - 0.75*Utils.PADDING, width: view.frame.width, height: 40))
        mdb_header.textAlignment = .center
        
        mdb_header.text = "MDB"
        mdb_header.textColor = UIColor.flatSkyBlueDark
        mdb_header.font = UIFont(name: "Avenir-Roman", size: 30)
        
        mdb_header.adjustsFontSizeToFitWidth = true
        view.addSubview(mdb_header)
        
    }
    
    func init_textfield() {
        username_field = UITextField(frame: CGRect(x: 2 * Utils.PADDING, y: socials_header.frame.maxY + Utils.PADDING, width: view.frame.width - 4 * Utils.PADDING, height: 40))
        
        username_field.backgroundColor = rgba(162,162,162,1)
        username_field.insetsLayoutMarginsFromSafeArea = true
        username_field.textColor = UIColor.white
        username_field.attributedPlaceholder = NSAttributedString(string: "Username",
                                                                  attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        
        username_field.layer.cornerRadius = 5
        username_field.textAlignment = .center
        username_field.tintColor = UIColor.white
        
        
        view.addSubview(username_field)
        
        
        
        password_field = UITextField(frame: CGRect(x: 2 * Utils.PADDING, y: username_field.frame.maxY + Utils.PADDING/2, width: view.frame.width - 4 * Utils.PADDING, height: 40))
        
        password_field.backgroundColor = rgba(162,162,162,1)
        password_field.insetsLayoutMarginsFromSafeArea = true
        password_field.textColor = UIColor.white
        password_field.attributedPlaceholder = NSAttributedString(string: "Password",
                                                                  attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        
        password_field.layer.cornerRadius = 5
        password_field.isSecureTextEntry = true
        password_field.textAlignment = .center
        password_field.tintColor = UIColor.white
        
        
        username_field.alpha = 0
        password_field.alpha = 0
        
        view.addSubview(password_field)
    }
    
    func init_buttons() {
        
        advance_to_login = UIButton(frame: CGRect(x: 3.5*Utils.PADDING, y: socials_header.frame.maxY + 2*Utils.PADDING, width: view.frame.width - 7*Utils.PADDING, height: 60))
        advance_to_login.setTitle("login", for: .normal)
        advance_to_login.titleLabel?.font = UIFont(name: "Avenir-Roman", size: 30)
        advance_to_login.backgroundColor = UIColor.flatSkyBlueDark
        advance_to_login.layer.cornerRadius = 5
        advance_to_login.addTarget(self, action: #selector(revealLogin), for: .touchUpInside)
        
        view.addSubview(advance_to_login)

        sign_up_button = UIButton(frame: CGRect(x: 4*Utils.PADDING, y: view.frame.height-60, width: view.frame.width - 8*Utils.PADDING, height: 40))
        sign_up_button.setTitle("New Here? Sign Up!", for: .normal)
        sign_up_button.setTitleColor(UIColor.flatGrayDark, for: .normal)

        view.addSubview(sign_up_button)
    }
    
    
    
}
