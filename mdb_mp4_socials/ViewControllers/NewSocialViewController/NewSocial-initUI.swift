//
//  NewSocial-initUI.swift
//  mdb_mp3_socials
//
//  Created by Ajay Raj Merchia on 9/27/18.
//  Copyright © 2018 Ajay Raj Merchia. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase

extension NewSocialViewController {
    func initUI() {
        init_nav()
        init_photopicker()
        init_text()
        init_textinput()
        init_datepicker()
        init_button()
    }
    
    func init_text() {
        imgPickerPrompt = UILabel(frame: CGRect(x: 0, y: eventImgPicker.frame.midY + Utils.PADDING, width: view.frame.width, height: 50))
        
        imgPickerPrompt.text = "Tap to add image"
        imgPickerPrompt.textAlignment = .center
        imgPickerPrompt.font = UIFont(name: "Avenir-Black", size: 24)
        imgPickerPrompt.textColor = .white
            
            
        view.addSubview(imgPickerPrompt)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
    
    func init_nav() {
        navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.font: Constants.navbarTitleFont!]
        
        
        navbar = UINavigationBar(frame: CGRect(x: 0, y: Utils.PADDING, width: view.frame.width, height: 50));
        navbar.tintColor = UIColor.flatGray
        navbar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navbar.shadowImage = UIImage()
        navbar.isTranslucent = true
        navbar.titleTextAttributes =
            [NSAttributedString.Key.font: Constants.navbarTitleFont!]

        
        self.view.addSubview(navbar)
        
        let navItem = UINavigationItem(title: "Create a New Social")
        
        
        
        let navBarbutton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.stop, target: self, action: #selector(go_back))
        navItem.leftBarButtonItem = navBarbutton
    
        
        navbar.items = [navItem]
        
        
    }
    
    @objc func go_back() {
        self.dismiss(animated: true, completion: {})
    }
    
    func init_textinput() {
        eventNameField = UITextField(frame: CGRect(x: Utils.PADDING, y: eventImgPicker.frame.maxY, width: view.frame.width - 2*Utils.PADDING, height: 80))
        eventNameField.placeholder = "Event Name"
        eventNameField.font = UIFont(name: "Avenir-Medium", size: 30)
        view.addSubview(eventNameField)
        
        
        eventLocationButt = UIButton(frame: CGRect(x: Utils.PADDING, y: eventNameField.frame.maxY-10, width: view.frame.width - 2*Utils.PADDING, height: 45))
        eventLocationButt.backgroundColor = .white
        eventLocationButt.setBackgroundColor(color: rgba(240,240,240,1), forState: .highlighted)
        eventLocationButt.setTitle("Choose a Location", for: .normal)
        eventLocationButt.setTitleColor(.lightGray, for: .normal)
        eventLocationButt.titleLabel?.font = UIFont(name: "Avenir-Light", size: 16)

        eventLocationButt.contentHorizontalAlignment = .left

        eventLocationButt.addTarget(self, action: #selector(locationPicker), for: .touchUpInside)
        view.addSubview(eventLocationButt)
        
        eventDescField = UITextView(frame: CGRect(x: Utils.PADDING, y: eventLocationButt.frame.maxY+Utils.PADDING, width: view.frame.width - 2*Utils.PADDING, height: 50))
        eventDescField.delegate = self
        eventDescField.text = "Event Description"
        eventDescField.textColor = UIColor.lightGray
        eventDescField.font = UIFont(name: "Avenir-Light", size: 20)

        eventDescField.textContainer.maximumNumberOfLines = 2
        eventDescField.textContainer.lineBreakMode = .byTruncatingTail

        view.addSubview(eventDescField)
    }
    
    func init_datepicker() {
        eventDateField = UIDatePicker(frame: CGRect(x: 50, y: eventDescField.frame.maxY+Utils.PADDING, width: view.frame.width-100, height: 100))
        
        view.addSubview(eventDateField)
    }
    
    func init_photopicker() {
        eventImgPicker = UIButton(frame: CGRect(x: 0, y: navbar.frame.maxY, width: view.frame.width, height: 2.0/3 * view.frame.width - 50))
        eventImgPicker.setImage(UIImage(named: "placeholder"), for: .normal)
    
        eventImgPicker.imageView?.contentMode = .scaleToFill
        eventImgPicker.addTarget(self, action: #selector(openActionSheet), for: .touchUpInside)
        view.insertSubview(eventImgPicker, at: 0)
        
    }
    
    func init_button() {
        createEvent = UIButton(frame: CGRect(x: 50, y: view.frame.height-75, width: view.frame.width-100, height: 50))
        createEvent.backgroundColor = UIColor.flatSkyBlueDark
        createEvent.layer.cornerRadius = 5
        createEvent.setTitle("Create Event", for: .normal)
        createEvent.addTarget(self, action: #selector(createTheEvent), for: .touchUpInside)
        view.addSubview(createEvent)
    }

}
