//
//  BusRoute.swift
//  GetOnTheBus
//
//  Created by Matthew Bracamonte on 4/5/16.
//  Copyright © 2016 Matthew Bracamonte. All rights reserved.
//

import UIKit

class BusRoute: NSObject {
    
    let cta_stop_name : String?
    let direction : String?
    let routes : String?
    let latitude : String?
    let longitude : String?
    
    init(propertyDict: Dictionary<String,AnyObject>) {
        self.cta_stop_name = propertyDict["cta_stop_name"] as! String?
        self.direction = propertyDict["direction"] as! String?
        self.routes = propertyDict["routes"] as! String?
        self.latitude = propertyDict["latitude"] as! String?
        self.longitude = propertyDict["longitude"] as! String?
    
    }
    
    

}
