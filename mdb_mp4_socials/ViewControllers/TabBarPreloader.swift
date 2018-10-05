//
//  TabBarPreloader.swift
//  mdb_mp4_socials
//
//  Created by Ajay Raj Merchia on 10/4/18.
//  Copyright © 2018 Ajay Raj Merchia. All rights reserved.
//

import UIKit

class TabBarPreloader: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        ((self.viewControllers?[1] as? UINavigationController)?.viewControllers[0] as! MyEventsViewController).initNav()
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
