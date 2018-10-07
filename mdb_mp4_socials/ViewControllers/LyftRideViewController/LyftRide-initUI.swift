//
//  LyftRide-initUI.swift
//  mdb_mp4_socials
//
//  Created by Ajay Raj Merchia on 10/5/18.
//  Copyright © 2018 Ajay Raj Merchia. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import CoreLocation

extension LyftRideViewController {
    func initUI (){
        initNav()
        initHeaders()
        initMap()
        initButtonsAndText()
    }
    
    func initHeaders() {
        headerText = UILabel(frame: CGRect(x: Utils.PADDING, y: view.frame.height/7, width: view.frame.width - 2 * Utils.PADDING, height: 40))
        headerText.text = event.title
        headerText.adjustsFontSizeToFitWidth = true
        headerText.textAlignment = .center
        headerText.font = UIFont(name: "Avenir-Black", size: 36)
        
        view.addSubview(headerText)
        
        subtitleText = UILabel(frame: CGRect(x: Utils.PADDING, y: headerText.frame.maxY, width: view.frame.width - 2 * Utils.PADDING, height: 30))
        subtitleText.text = "Let's get you to \(locationDesc!)"
        subtitleText.adjustsFontSizeToFitWidth = true
        subtitleText.textAlignment = .center
        subtitleText.font = UIFont(name: "Avenir-Light", size: 16)
        view.addSubview(subtitleText)
        
}
    
    func initNav() {
        navbar = UINavigationBar(frame: CGRect(x: 0, y: Utils.PADDING, width: view.frame.width, height: 50));
        navbar.tintColor = UIColor.flatSkyBlueDark
        navbar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navbar.shadowImage = UIImage()
        navbar.isTranslucent = true
        navbar.titleTextAttributes = [NSAttributedString.Key.font: Constants.navbarTitleFont!]
        
        
        self.view.addSubview(navbar)
        
        let navItem = UINavigationItem(title: "Request a Lyft")
        
        let navBarbutton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.stop, target: self, action: #selector(goBack))
        navItem.leftBarButtonItem = navBarbutton

        navbar.items = [navItem]
    }
    
    func initButtonsAndText() {
        
        let button_width = view.frame.width/5
        
        for i in 0..<3 {
            let spacing = view.frame.width/3.5
            
            let offset:CGFloat = CGFloat(i) - 1.0
            let centered_x = CGFloat(view.frame.width/2) + spacing*offset
            
            let currButton = UIButton(frame: CGRect(x: centered_x - button_width/2, y: mapView.frame.maxY + Utils.PADDING, width: button_width, height: button_width))
            
            currButton.setImage(UIImage(named: tierOptions[i].lowercased()), for: .normal)
            currButton.imageView?.layer.cornerRadius = 0.5 * button_width
            currButton.imageView?.contentMode = .scaleAspectFit
            currButton.imageView?.clipsToBounds = true
            currButton.tag = i
            tierSelectors.append(currButton)
            view.addSubview(currButton)
            
            let currTitle = UILabel(frame: CGRect(x: currButton.frame.minX, y: currButton.frame.maxY, width: button_width, height: 28))
            currTitle.text = tierOptions[i]
            currTitle.font = UIFont(name: "Avenir-Medium", size: 24)
            currTitle.textAlignment = .center
            tierTitles.append(currTitle)
            view.addSubview(currTitle)

            let currPrice = UILabel(frame: CGRect(x: currButton.frame.minX, y: currTitle.frame.maxY, width: button_width, height: 20))
            currPrice.text = "$\(i+4).00"
            currPrice.font = UIFont(name: "Avenir-Light", size: 14)
            currPrice.textAlignment = .center
            tierPrices.append(currPrice)
            view.addSubview(currPrice)

            
        }
        
        let instructionLabel = UILabel(frame: CGRect(x: Utils.PADDING, y: tierPrices[0].frame.maxY+Utils.PADDING/2 , width: view.frame.width-2*Utils.PADDING, height: 20))
        instructionLabel.text = "Tap to select your ride."
        instructionLabel.textColor = UIColor.flatGrayDark
        instructionLabel.font = UIFont(name: "Avenir-Light", size: 12)
        instructionLabel.textAlignment = .center
        view.addSubview(instructionLabel)
        
        let disclaimer = UILabel(frame: CGRect(x: Utils.PADDING, y: instructionLabel.frame.maxY , width: view.frame.width-2*Utils.PADDING, height: 20))
        disclaimer.text = "Rates are an estimate and availability may vary."
        disclaimer.textColor = UIColor.flatGrayDark
        disclaimer.font = UIFont(name: "Avenir-Light", size: 10)
        disclaimer.textAlignment = .center
        view.addSubview(disclaimer)
        
        
    }
    
    @objc func goBack() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
}
