//
//  Feed-tableview.swift
//  mdb_mp3_socials
//
//  Created by Ajay Raj Merchia on 9/28/18.
//  Copyright © 2018 Ajay Raj Merchia. All rights reserved.
//

import Foundation
import UIKit

extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventsList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height/2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "socialcell") as! SocialCell
        for subview in cell.contentView.subviews {
            subview.removeFromSuperview()
        }
        
        // Initialize Cell
        cell.awakeFromNib()
        cell.initialCellFrom(event: eventsList[indexPath.row])
        guard let curr_user = (self.navigationController as! AccountNavController).logged_in_fullname else {
            return cell
        }
        cell.currName = curr_user
        
        if eventsList[indexPath.row].interestedMembers.contains(curr_user) {
            cell.interested.isSelected = true
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedEvent = eventsList[indexPath.row]
        performSegue(withIdentifier: "feed2detail", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
    
}
