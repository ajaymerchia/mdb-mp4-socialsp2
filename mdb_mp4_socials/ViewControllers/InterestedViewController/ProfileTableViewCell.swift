//
//  ProfileCellTableViewCell.swift
//  mdb_mp4_socials
//
//  Created by Ajay Raj Merchia on 10/5/18.
//  Copyright © 2018 Ajay Raj Merchia. All rights reserved.
//

import UIKit


class ProfileTableViewCell: UITableViewCell {

    var profileImage: UIImageView!
    var profileName: UILabel!
    var triggerEmail: UIButton!
    
    var userEmail: String!
    var eventName: String!
    
    let email_size: CGFloat = 50
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        profileImage = UIImageView(frame: CGRect(x: Utils.PADDING, y: 0, width: contentView.frame.width/3.5, height: contentView.frame.width/3.5))

        profileImage.contentMode = .scaleAspectFill
        profileImage.clipsToBounds = true
        profileImage.layer.borderWidth = 0.5
        profileImage.layer.borderColor = rgba(162,162,162,1).cgColor
        
//        profileName = UILabel(frame: )
        profileName = UILabel(frame: CGRect(x: profileImage.frame.maxX + Utils.PADDING, y: profileImage.frame.minY + 10, width: contentView.frame.width - (profileImage.frame.maxX + Utils.PADDING), height: 40))
        
        profileName.adjustsFontSizeToFitWidth = true
        profileName.font = UIFont(name: "Avenir-Medium", size: 24)
        
        triggerEmail = UIButton(frame: CGRect(x: profileName.frame.minX, y: profileName.frame.maxY, width: email_size, height: email_size))
        triggerEmail.setImage(UIImage(named: "test_butt"), for: .normal)
        
        contentView.addSubview(profileImage)
        contentView.addSubview(profileName)
        contentView.addSubview(triggerEmail)
        
    }
    
    func repairFrames() {
        profileImage.frame = computeFrameFromPoint(oldFrame: profileImage.frame, center: profileImage.center)
        profileImage.layer.cornerRadius = 0.5 * profileImage.frame.width
        
        profileName.frame = CGRect(x: profileImage.frame.maxX + Utils.PADDING, y: profileImage.frame.minY + 10, width: contentView.frame.width - (profileImage.frame.maxX + Utils.PADDING), height: 30)
        
        triggerEmail.frame = CGRect(x: profileName.frame.minX, y: profileName.frame.maxY, width: email_size, height: email_size)
        
        
    }
    
    func computeFrameFromPoint(oldFrame: CGRect, center: CGPoint) -> CGRect {
        return CGRect(x: center.x - oldFrame.width/2, y: center.y - oldFrame.height/2, width: oldFrame.width, height: oldFrame.height)
    }
    
    func initializeViewFrom(user: User, event: Event) {
        profileImage.image = user.image
        profileName.text = user.properName
        userEmail = user.email
        eventName = event.title
    }
    
   

}
