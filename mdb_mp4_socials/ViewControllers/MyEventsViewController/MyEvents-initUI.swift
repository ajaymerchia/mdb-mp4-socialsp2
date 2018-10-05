//
//  MyEvents-initUI.swift
//  mdb_mp4_socials
//
//  Created by Ajay Raj Merchia on 10/4/18.
//  Copyright © 2018 Ajay Raj Merchia. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth

extension MyEventsViewController {
    func initUI() {
        initTableView()
        view.backgroundColor = .flatWhite
    }
    
    func initNav() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(go_to_new_social))
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: UIBarButtonItem.Style.done, target: self, action: #selector(logout))
        
        
        self.navigationItem.title = "My Events"
        self.navigationItem.leftBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Avenir-Roman", size: 21)!], for: UIControl.State.normal)
        
        
        self.tabBarItem = UITabBarItem(title: "My Events", image: UIImage(named: "myevents_inactive"), selectedImage: UIImage(named: "myevents_active2"))
        
        
    }
    
    @objc func go_to_new_social() {
        performSegue(withIdentifier: "myevent2new", sender: self)
    }
    
    @objc func logout() {
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
        LocalData.deleteLocalData(forKey: .username)
        LocalData.deleteLocalData(forKey: .fullname)
        
        
        self.presentingViewController?.dismiss(animated: true)
    }
    
    
    func initTableView() {
        socialsList = UITableView(frame: CGRect(x:Utils.PADDING, y: UIApplication.shared.statusBarFrame.maxY, width: view.frame.width-2*Utils.PADDING, height: view.frame.height-UIApplication.shared.statusBarFrame.maxY))
        socialsList.register(SocialCell.self, forCellReuseIdentifier: "socialcell")
        socialsList.delegate = self
        socialsList.dataSource = self
        socialsList.backgroundColor = .flatWhite
        socialsList.rowHeight = view.frame.height/3
        socialsList.showsVerticalScrollIndicator = false
        view.addSubview(socialsList)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailVC = segue.destination as? DetailViewController {
            detailVC.event = selectedEvent
        }
    }
    
    
}
