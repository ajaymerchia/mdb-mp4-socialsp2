//
//  Interested-initUI.swift
//  mdb_mp4_socials
//
//  Created by Ajay Raj Merchia on 10/5/18.
//  Copyright © 2018 Ajay Raj Merchia. All rights reserved.
//

import Foundation
import UIKit

extension InterestedViewController {
    func initUI() {
        initNav()
        initTableView()
    }
    
    func initNav() {
        navbar = UINavigationBar(frame: CGRect(x: 0, y: Utils.PADDING, width: view.frame.width, height: 50));
        navbar.tintColor = UIColor.flatSkyBlueDark
        navbar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navbar.shadowImage = UIImage()
        navbar.isTranslucent = true
        navbar.titleTextAttributes = [NSAttributedString.Key.font: Constants.navbarTitleFont!]

        
        self.view.addSubview(navbar)
        
        let navItem = UINavigationItem(title: "Who's Interested")
        let navBarbutton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.stop, target: self, action: #selector(goBack))
        navItem.leftBarButtonItem = navBarbutton
        
        
        
        navbar.items = [navItem]
    }
    
    func initTableView() {
        
        displayedList = UITableView(frame: CGRect(x:0, y: navbar.frame.maxY, width: view.frame.width, height: view.frame.height-navbar.frame.maxY))
        
        displayedList.register(ProfileTableViewCell.self, forCellReuseIdentifier: "profilecell")
        displayedList.delegate = self
        displayedList.dataSource = self
        displayedList.backgroundColor = .flatWhite
        displayedList.allowsSelection = false
        displayedList.rowHeight = 50
        displayedList.showsVerticalScrollIndicator = false
        view.addSubview(displayedList)
        
    }
    
    @objc func goBack() {
        self.dismiss(animated: true, completion: nil)
    }
}
