//
//  DetailViewController.swift
//  mdb_mp3_socials
//
//  Created by Ajay Raj Merchia on 9/27/18.
//  Copyright © 2018 Ajay Raj Merchia. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var event: Event!
    var currUser: String!

    
    var event_img: UIImageView!
    var event_title: UILabel!
    var event_description: UILabel!
    var event_poster: UILabel!
    var interested_list: UILabel!
    var num_interested_label: UILabel!
    
    var event_date: UILabel!
    var event_time: UILabel!
    
    var interestButton: UIButton!
    
    
    var width: CGFloat!
    let marginal_padding:CGFloat = 2.5
    let left_pad_mult: CGFloat = 7
    
    
    
    
    
   

    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
        debugPrint(event, event.event_id)

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
