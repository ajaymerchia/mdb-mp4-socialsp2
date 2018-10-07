//
//  Interested-tableview.swift
//  mdb_mp4_socials
//
//  Created by Ajay Raj Merchia on 10/5/18.
//  Copyright © 2018 Ajay Raj Merchia. All rights reserved.
//

import Foundation
import UIKit
import MessageUI

extension InterestedViewController: UITableViewDelegate, UITableViewDataSource, MFMailComposeViewControllerDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height/6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "profilecell") as! ProfileTableViewCell
        
        for subview in cell.contentView.subviews {
            subview.removeFromSuperview()
        }
        
        // Initialize Cell
        cell.awakeFromNib()
        cell.initializeViewFrom(user: userList[indexPath.row], event: event)
        cell.profileImage.frame = CGRect(x: Utils.PADDING, y: 0, width: view.frame.width/5, height: view.frame.width/5)
        cell.profileImage.center = CGPoint(x: Utils.PADDING*2, y: tableView.frame.height/12)
        
        cell.triggerEmailIcon.center = CGPoint(x: tableView.frame.width - (Utils.PADDING + cell.email_size/2), y: cell.profileImage.frame.midY)
        
        
        cell.repairFrames()
        
        
        
        cell.triggerEmail.addTarget(self, action: #selector(sendEmail), for: .touchUpInside)
        cell.triggerEmail.tag = indexPath.row
        
        cell.triggerEmailIcon.addTarget(self, action: #selector(sendEmail), for: .touchUpInside)
        cell.triggerEmailIcon.tag = indexPath.row
        
        
        return cell
    }
    
    @objc func sendEmail(sender: UIButton) {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        mailComposerVC.setToRecipients([userList[sender.tag].email])
        mailComposerVC.setSubject(event.title)
        mailComposerVC.setMessageBody("Hey \(userList[sender.tag].properName!),", isHTML: false)
        self.present(mailComposerVC, animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
}
