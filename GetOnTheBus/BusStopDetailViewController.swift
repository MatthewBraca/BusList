//
//  BusStopDetailViewController.swift
//  GetOnTheBus
//
//  Created by Matthew Bracamonte on 4/6/16.
//  Copyright © 2016 Matthew Bracamonte. All rights reserved.
//

import UIKit

class BusStopDetailViewController: UIViewController {
    
    
    @IBOutlet weak var busStopNameOutlet: UILabel!
    @IBOutlet weak var busStopRouteOutlet: UILabel!
    
    var busStopName : String = ""
    var busStopRoute : String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        busStopNameOutlet.text = busStopName
        busStopRouteOutlet.text = busStopRoute
    }

  

 
}
