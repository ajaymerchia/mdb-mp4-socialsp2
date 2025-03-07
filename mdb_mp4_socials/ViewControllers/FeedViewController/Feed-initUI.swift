//
//  Feed-initUI.swift
//  mdb_mp3_socials
//
//  Created by Ajay Raj Merchia on 9/27/18.
//  Copyright © 2018 Ajay Raj Merchia. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase
import FirebaseAuth

extension FeedViewController {
    func initUI() {
        view.backgroundColor = UIColor.flatWhite
        initNav()
        addListView()
    }
    
    
    /// Adds the TableView to the ViewController
    func addListView() {
        socialsList = UITableView(frame: CGRect(x:Utils.PADDING, y: UIApplication.shared.statusBarFrame.maxY, width: view.frame.width-2*Utils.PADDING, height: view.frame.height-UIApplication.shared.statusBarFrame.maxY))
        socialsList.register(SocialCell.self, forCellReuseIdentifier: "socialcell")
        socialsList.delegate = self
        socialsList.dataSource = self
        socialsList.backgroundColor = .flatWhite
        socialsList.rowHeight = view.frame.height/3
        socialsList.showsVerticalScrollIndicator = false
        view.addSubview(socialsList)
    }
    
    func initNav() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(go_to_new_social))
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: UIBarButtonItem.Style.done, target: self, action: #selector(logout))
        
        self.navigationItem.leftBarButtonItem?.tintColor = .red
        
        self.navigationItem.title = "Hello, \(LocalData.getLocalData(forKey: .fullname)!)"
     
        
        
        self.tabBarItem = UITabBarItem(title: "Feed", image: UIImage(named: "feed_inactive"), selectedImage: UIImage(named: "feed_active"))
        
    }
    
    
    
    @objc func logout() {
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }

        LocalData.deleteLocalData(forKey: .fullname)
        LocalData.deleteLocalData(forKey: .username)

        self.presentingViewController?.dismiss(animated: true)
    }
    
    
    @objc func go_to_new_social() {
        performSegue(withIdentifier: "feed2new", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let VC = segue.destination as? DetailViewController {
            VC.event = selectedEvent
        }
    }
    
    
}
