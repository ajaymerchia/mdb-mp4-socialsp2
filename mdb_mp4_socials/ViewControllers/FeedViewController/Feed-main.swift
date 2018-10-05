//
//  FeedViewController.swift
//  mdb_mp3_socials
//
//  Created by Ajay Raj Merchia on 9/27/18.
//  Copyright © 2018 Ajay Raj Merchia. All rights reserved.
//

import UIKit
import ChameleonFramework

class FeedViewController: UIViewController {
    
    var socialsList: UITableView!
    var eventsList: [Event] = []
    var selectedEvent: Event!
    let save_the_quota = false
    
    var numReloads = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
        newEventListener()
        initEventUpdater()
        socialsList.reloadData()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if numReloads < 2 {
            socialsList.reloadData()
        }
        numReloads = numReloads + 1

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
