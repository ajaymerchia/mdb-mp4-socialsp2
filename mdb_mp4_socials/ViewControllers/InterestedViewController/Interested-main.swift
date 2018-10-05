//
//  InterestedViewController.swift
//  mdb_mp4_socials
//
//  Created by Ajay Raj Merchia on 10/5/18.
//  Copyright © 2018 Ajay Raj Merchia. All rights reserved.
//

import UIKit
import JGProgressHUD
class InterestedViewController: UIViewController {

    var event: Event!
    var interestList: [String: String]!
    var userList: [User] = []
    var displayedList: UITableView!
    var navbar: UINavigationBar!
    var hud: JGProgressHUD?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        getAllUserImages()

        // Do any additional setup after loading the view.
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
