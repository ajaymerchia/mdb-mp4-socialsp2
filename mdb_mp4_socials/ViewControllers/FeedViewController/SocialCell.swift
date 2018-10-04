//
//  SocialCell.swift
//  mdb_mp3_socials
//
//  Created by Ajay Raj Merchia on 9/28/18.
//  Copyright © 2018 Ajay Raj Merchia. All rights reserved.
//

import UIKit
import FirebaseDatabase

class SocialCell: UITableViewCell {

    var event_id: String!
    
    var socialImage: UIImageView!
    var socialName: UILabel!
    var socialDesc: UILabel!
    
    var socialHost: UILabel!
    
    var interested: UIButton!
    var numInterested: UILabel!
    
    var currName: String!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        contentView.backgroundColor = Utils.generateRandomColor()

        let width = contentView.frame.width
        let marginal_padding:CGFloat = 2.5
        let left_pad_mult: CGFloat = 7
        
        // Initialization code
        socialImage = UIImageView(frame: CGRect(x:0, y: 0, width: width+100, height: 150))
        socialImage.contentMode = .scaleAspectFill
        socialImage.clipsToBounds = true
        
        socialName = UILabel(frame: CGRect(x: left_pad_mult*marginal_padding, y: socialImage.frame.maxY+8*marginal_padding, width: contentView.frame.width-2*left_pad_mult*marginal_padding, height: 25))
        socialName.font = UIFont(name: "Avenir-Black", size: 25)
        
        socialHost = UILabel(frame: CGRect(x: left_pad_mult*marginal_padding, y: socialName.frame.maxY+marginal_padding*2, width: contentView.frame.width-2*left_pad_mult*marginal_padding, height: 20))
        socialHost.font = UIFont(name: "Avenir-Oblique", size: 18)
        socialHost.textColor = UIColor.flatGrayDark
        
        socialDesc = UILabel(frame: CGRect(x: left_pad_mult*marginal_padding, y: socialName.frame.maxY+12*marginal_padding, width: contentView.frame.width-2*left_pad_mult*marginal_padding, height: 60))
        socialDesc.numberOfLines = 2
        socialDesc.lineBreakMode = NSLineBreakMode.byWordWrapping
        socialDesc.font = UIFont(name: "Avenir-Roman", size: 16)

    
        let additionalSeparatorThickness:CGFloat = 20
        
        let additionalSeparator = UIView(frame: CGRect(x: 0, y: contentView.frame.height - additionalSeparatorThickness, width: contentView.frame.width, height: additionalSeparatorThickness))
        
        additionalSeparator.backgroundColor = UIColor.flatWhite
        
        interested = UIButton(frame: CGRect(x: left_pad_mult*marginal_padding, y: socialDesc.frame.maxY + Utils.PADDING/2.5, width: 30, height: 30))
        interested.setImage(UIImage(named: "star_hollow"), for: .normal)
        interested.setImage(UIImage(named: "star"), for: .selected)
        interested.addTarget(self, action: #selector(toggleInterest), for: .touchUpInside)
        
        numInterested = UILabel(frame: CGRect(x: interested.frame.maxX + left_pad_mult-0.5 * marginal_padding, y: interested.frame.minY, width: contentView.frame.width, height: 30))
        
        numInterested.font = UIFont(name: "Avenir-Roman", size: 24)
        
        let underlineThickness:CGFloat = 2
        let underline = UIView(frame: CGRect(x: left_pad_mult*marginal_padding, y: socialHost.frame.maxY+marginal_padding, width: contentView.frame.width-2*left_pad_mult*marginal_padding, height: underlineThickness))
        
        underline.backgroundColor = UIColor.flatWhiteDark
        
        
        
        
        contentView.addSubview(additionalSeparator)
        contentView.addSubview(underline)
        
        contentView.addSubview(socialImage)
        contentView.addSubview(socialName)
        contentView.addSubview(socialDesc)
        contentView.addSubview(socialHost)
        contentView.addSubview(interested)
        contentView.addSubview(numInterested)
        
    }
    
    func initialCellFrom(event: Event) {
        socialImage.image = event.image
        socialName.text = event.title
        socialDesc.text = event.description
        socialHost.text = "Host: " + event.poster
        numInterested.text = "\(event.numInterested ?? 0) Interested"
        
        event_id = event.event_id
        
        
        
        
    }
    
    @objc func toggleInterest() {
        interested.isSelected = !interested.isSelected
        var delta = 0
        if interested.isSelected {
            debugPrint("adding interest")
            delta = 1
        } else {
            debugPrint("removing interested")
            delta = -1
        }
        
        updateInterestForEvent(id: event_id, amt: delta)
        
    }
    
    func updateInterestForEvent(id: String, amt: Int) {
        let interestRef = Database.database().reference().child("events").child(id)
        interestRef.observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            guard let value = snapshot.value as? NSDictionary else {
                return
            }
            var count = value["numInterested"] as! Int
            var interested_folks = value["interestedMembers"] as? [String] ?? []
            
            
            let alreadyThere = interested_folks.contains(self.currName)
            
            if !alreadyThere && amt > 0 {
                interested_folks.append(self.currName)
                count += amt
            } else if alreadyThere && amt < 0{
                interested_folks.remove(at: interested_folks.index(of: self.currName)!)
                count += amt
            }
            
            interestRef.updateChildValues(["numInterested": count, "interestedMembers": interested_folks], withCompletionBlock: { (error, ref) in
                if error != nil {
                    return
                } else {
                    
                    self.numInterested.text = "\(count) Interested"
                    
                }
            })
            
            
        })
    }
    
    
    

}
