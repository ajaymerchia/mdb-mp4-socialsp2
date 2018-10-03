//
//  Detail-initUI.swift
//  mdb_mp3_socials
//
//  Created by Ajay Raj Merchia on 9/28/18.
//  Copyright © 2018 Ajay Raj Merchia. All rights reserved.
//

import Foundation
import UIKit

extension DetailViewController {
    func initUI() {
        width = view.frame.width
        currUser = (self.navigationController as! AccountNavController).logged_in_fullname!
        init_img()
        init_text()
        init_buttons()
        
        if event.interestedMembers.contains(currUser) {
            interestButton.isSelected = true
        }
        
    }
    
    
    func init_img() {
        // Initialization code
        event_img = UIImageView(frame: CGRect(x:0, y: 0, width: width, height: 250))
        event_img.contentMode = .scaleAspectFill
        event_img.clipsToBounds = true
        event_img.image = event.image
        
        view.addSubview(event_img)
    }
    
    func init_text() {
        event_title = UILabel(frame: CGRect(x: left_pad_mult*marginal_padding, y: event_img.frame.maxY+8*marginal_padding, width: view.frame.width-2*left_pad_mult*marginal_padding, height: 25))
        event_title.text = event.title
        event_title.font = UIFont(name: "Avenir-Black", size: 25)
        
        
        
        event_poster = UILabel(frame: CGRect(x: left_pad_mult*marginal_padding, y: event_title.frame.maxY+marginal_padding*2, width: view.frame.width-2*left_pad_mult*marginal_padding, height: 20))
        event_poster.text = event.poster
        event_poster.font = UIFont(name: "Avenir-Oblique", size: 18)
        event_poster.textColor = UIColor.flatGrayDark
        
        event_description = UILabel(frame: CGRect(x: left_pad_mult*marginal_padding, y: event_title.frame.maxY+12*marginal_padding, width: view.frame.width-2*left_pad_mult*marginal_padding, height: 60))
        event_description.text = event.description
        event_description.numberOfLines = 2
        event_description.lineBreakMode = NSLineBreakMode.byWordWrapping
        event_description.font = UIFont(name: "Avenir-Roman", size: 16)
        
        
        
        
        let underlineThickness:CGFloat = 2
        let underline = UIView(frame: CGRect(x: left_pad_mult*marginal_padding, y: event_poster.frame.maxY+marginal_padding, width: view.frame.width-2*left_pad_mult*marginal_padding, height: underlineThickness))
        
        underline.backgroundColor = UIColor.flatWhiteDark
        
        
        
        event_time = UILabel(frame: CGRect(x: left_pad_mult*marginal_padding, y: event_img.frame.maxY+8*marginal_padding, width: view.frame.width-2*left_pad_mult*marginal_padding, height: 25))
        let timeFormatter = DateFormatter()
        timeFormatter.dateStyle = .none
        timeFormatter.timeStyle = .short
        timeFormatter.locale = Locale(identifier: "en_US")
        
        event_time.text = timeFormatter.string(from: event.date)
        event_time.textAlignment = .right
        event_time.font = UIFont(name: "Avenir-Black", size: 25)
        
        
        event_date = UILabel(frame: CGRect(x: left_pad_mult*marginal_padding, y: event_title.frame.maxY+marginal_padding*2, width: view.frame.width-2*left_pad_mult*marginal_padding, height: 20))
        event_date.textAlignment = .right
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "en_US")
        
        event_date.text = dateFormatter.string(from: event.date)
        event_date.textAlignment = .right
        event_date.font = UIFont(name: "Avenir-Black", size: 25)
        
        event_date.font = UIFont(name: "Avenir-Oblique", size: 18)
        event_date.textColor = UIColor.flatGrayDark
        
        
        
        
        view.addSubview(underline)
        view.addSubview(event_title)
        view.addSubview(event_description)
        view.addSubview(event_poster)
        view.addSubview(event_time)
        view.addSubview(event_date)
        
    }
    
    func init_buttons() {
        interestButton = UIButton(frame: CGRect(x: left_pad_mult*marginal_padding, y: event_description.frame.maxY + Utils.PADDING/2.5, width: 30, height: 30))
        interestButton.setImage(UIImage(named: "star_hollow"), for: .normal)
        interestButton.setImage(UIImage(named: "star"), for: .selected)
        interestButton.addTarget(self, action: #selector(updateInterestCount), for: .touchUpInside)
        interestButton.titleLabel?.font = UIFont(name: "Avenir-Roman", size: 24)

        num_interested_label = UILabel(frame: CGRect(x: interestButton.frame.maxX + left_pad_mult-0.5 * marginal_padding, y: interestButton.frame.minY, width: width, height: 30))
        num_interested_label.font = UIFont(name: "Avenir-Roman", size: 16)

        num_interested_label.text = "\(event.numInterested ?? 0) Interested"
        
        
        
        interested_list = UILabel(frame:CGRect(x: Utils.PADDING, y: num_interested_label.frame.maxY + Utils.PADDING, width: view.frame.width, height: 20))
        interested_list.text = "Guest List: " + (event.interestedMembers).joined(separator: ", ")
        interested_list.font = UIFont(name: "Avenir-Roman", size: 14)

        

        view.addSubview(interestButton)
        view.addSubview(num_interested_label)
        view.addSubview(interested_list)

        

    }
}
