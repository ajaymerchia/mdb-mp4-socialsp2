//
//  MyEvents-tableview.swift
//  mdb_mp4_socials
//
//  Created by Ajay Raj Merchia on 10/5/18.
//  Copyright © 2018 Ajay Raj Merchia. All rights reserved.
//

import Foundation
import UIKit

extension MyEventsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventsList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height/1.8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "socialcell") as! SocialCell
        for subview in cell.contentView.subviews {
            subview.removeFromSuperview()
        }
        
        // Initialize Cell
        cell.awakeFromNib()
        cell.initialCellFrom(event: eventsList[indexPath.row])
        guard let curr_user = LocalData.getLocalData(forKey: .fullname) else {
            return cell
        }
        cell.currName = curr_user
        
        if eventsList[indexPath.row].interestedMembers.values.contains(curr_user) {
            cell.interested.isSelected = true
        }
        
        cell.additionalSeparator.frame = CGRect(x: 0, y: tableView.frame.height/1.8 - cell.additionalSeparatorThickness, width: cell.contentView.frame.width + 100, height: cell.additionalSeparatorThickness)
        
        cell.setNeedsLayout()
        cell.layoutIfNeeded()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedEvent = eventsList[indexPath.row]
        performSegue(withIdentifier: "myevent2detail", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func reload(tableView: UITableView) {
        let contentOffset = tableView.contentOffset
        tableView.reloadData()
        tableView.setContentOffset(contentOffset, animated: false)
        
    }
}
