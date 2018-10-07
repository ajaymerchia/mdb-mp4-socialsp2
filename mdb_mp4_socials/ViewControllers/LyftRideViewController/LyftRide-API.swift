//
//  LyftRide-API.swift
//  mdb_mp4_socials
//
//  Created by Ajay Raj Merchia on 10/5/18.
//  Copyright © 2018 Ajay Raj Merchia. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import LyftSDK
import CoreLocation

extension LyftRideViewController {
    func APIConnect() {
//        getAuthToken()
        getPriceEstimates()
        
    }
    
    func getPriceEstimates() {
        let src = mapView.userLocation.coordinate
        guard let des = event.location?.coordinate else {
            lyftFailed()
            return
        }
        
        
        for i in 0..<3 {
            updateCostFor(label: tierPrices[i], type: rideTypes[i], from: src, to: des)
            deepLink(button: tierSelectors[i], type: rideTypes[i], from: src, to: des)
        }
        
        
    }
    
    func updateCostFor(label: UILabel, type: RideKind, from: CLLocationCoordinate2D, to: CLLocationCoordinate2D) {
        LyftAPI.costEstimates(from: from, to: to, rideKind: type, completion: {resp in
            debugPrint(resp)
            guard let costObj = resp.value else {
                self.lyftFailed(label: label)
                return
            }
            guard let estimate = costObj[0].estimate else {
                self.lyftFailed(label: label)
                return
            }
            
            let max = (estimate.maxEstimate.amount as NSDecimalNumber).intValue
            
            label.text = "$\(max).00"
            
            
            
        })
        
        
    }
    
    func lyftInstalled() -> Bool {
        return UIApplication.shared.canOpenURL(URL(string: "lyft://")!)
    }
    
    func open(scheme: String) {
        var adjustedScheme = scheme
        if !lyftInstalled() {
            adjustedScheme = "itms-apps://itunes.apple.com/app/id529379082"
        }
        if let url = URL(string: adjustedScheme) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    func deepLink(button: UIButton, type: RideKind, from: CLLocationCoordinate2D, to: CLLocationCoordinate2D) {
        
        let deepLinkURL = "lyft://ridetype?id=\(type.rawValue)&pickup[latitude]=\(from.latitude)&pickup[longitude]=\(from.longitude)&destination[latitude]=\(to.latitude)&destination[longitude]=\(to.longitude)"
        
        deepLinkTargets[type.rawValue] = deepLinkURL
        button.addTarget(self, action: #selector(triggerDeeplink), for: .touchUpInside)
    }
    
    @objc func triggerDeeplink(sender:UIButton) {
        open(scheme: deepLinkTargets[rideTypes[sender.tag].rawValue]!)
    }
    
    
    
    
    
    func lyftFailed() {
        for label in tierPrices {
            lyftFailed(label: label)
        }
    }
    
    func lyftFailed(label: UILabel) {
        label.text = "Not Available"
        label.adjustsFontSizeToFitWidth = true
    }
    
    func getAuthToken() {
        let authURL = "https://api.lyft.com/oauth/token"
        var parameters: HTTPHeaders = ["Accept": "application/json"]

        parameters["scope"] = "public"
        parameters["grant_type"] = "client_credentials"

        let clientID = "iUPYolLGocwK"
        let clientSecret = "X25n6C35sDeKKYZDotogytaz91q93wp-"

        if let authorizationHeader = Request.authorizationHeader(user: clientID, password: clientSecret) {
            parameters[authorizationHeader.key] = authorizationHeader.value
        }

        debugPrint(parameters)

        Alamofire.request(authURL, method: .post, parameters: parameters, encoding: URLEncoding(), headers: ["Content-Type": "application/x-www-form-urlencoded"]).responseJSON { response in
            //Makes sure that response is valid
            let json = JSON(response.result.value!)
            debugPrint(json)

        }
    }
    
}
