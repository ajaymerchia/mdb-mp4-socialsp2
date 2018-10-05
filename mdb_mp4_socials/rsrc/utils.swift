//
//  utils.swift
//  mdb_mp3_socials
//
//  Created by Ajay Raj Merchia on 9/27/18.
//  Copyright © 2018 Ajay Raj Merchia. All rights reserved.
//

import Foundation
import UIKit

class LocalData {
    static let username = LocalData("username")
    static let fullname = LocalData("fullname")
    
    var key_name: String!
    
    private init(_ key: String) {
        key_name = key
    }
    
    static func throwCredentialError(_ view: UIView) {
        fatalError("Should not be able to access \(String(describing: view)) without being logged in and have data in UserDefaults ")
    }
    
    static func throwCredentialError(_ view: UIViewController) {
        fatalError("Should not be able to access \(String(describing: view)) without being logged in and have data in UserDefaults ")
    }
    
    static func getLocalData(forKey: LocalData) -> String? {
        let defaults = UserDefaults.standard
        guard let str = defaults.string(forKey: forKey.key_name) else {
            return nil
        }
        return str
    }
    
    static func putLocalData(forKey: LocalData, data: String) {
        let defaults = UserDefaults.standard
        defaults.set(data, forKey: forKey.key_name)
    }
    
    static func deleteLocalData(forKey: LocalData) {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: forKey.key_name)
    }
}

class Utils {
    static let PADDING:CGFloat = 30
    
    /// Adds the question mark based background image to the given view
    ///
    /// - Parameter given_view: View to which a background image should be added
    static func addBackgroundImage(given_view: UIView) {
        let backgroundImage = UIImageView(frame: CGRect(x: 0, y: 0, width: given_view.frame.width, height: given_view.frame.height))
        backgroundImage.image = UIImage(named: "plain_background")
        given_view.insertSubview(backgroundImage, at: 0)
    }
    
    
    

    /// Prints all Fonts that have been loaded into the application
    static func printFontFamilies() {
        for family in UIFont.familyNames.sorted() {
            let names = UIFont.fontNames(forFamilyName: family)
            print("Family: \(family) Font names: \(names)")
        }
    }
    
    static func generateRandomColor() -> UIColor {
        let hue : CGFloat = CGFloat(arc4random() % 256) / 256 // use 256 to get full range from 0.0 to 1.0
        let saturation : CGFloat = CGFloat(arc4random() % 128) / 256 + 0.5 // from 0.5 to 1.0 to stay away from white
        let brightness : CGFloat = CGFloat(arc4random() % 128) / 256 + 0.5 // from 0.5 to 1.0 to stay away from black
        
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1)
    }
    
    
    
    
}

extension String
{
    func toDateTime() -> Date
    {
        //Create Date Formatter
        let dateFormatter = DateFormatter()
        
        //Specify Format of String to Parse
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss xxx"
        
        //Parse into NSDate
        let dateFromString : Date = dateFormatter.date(from: self)!
        
        //Return Parsed Date
        return dateFromString
    }
}

extension UIButton {
    func setBackgroundColor(color: UIColor, forState: UIControl.State) {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        UIGraphicsGetCurrentContext()!.setFillColor(color.cgColor)
        UIGraphicsGetCurrentContext()!.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        self.setBackgroundImage(colorImage, for: forState)
    }}
