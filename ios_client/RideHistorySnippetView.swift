//
//  RideHistorySnippetView.swift
//  ios_client
//
//  Created by Max Dignan on 6/2/18.
//  Copyright © 2018 RideZoot. All rights reserved.
//

import UIKit
import SwiftyJSON

class RideHistorySnippetView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    @IBOutlet var rideID : UILabel!
    
    @IBOutlet var distLabel : UILabel!
    @IBOutlet var timeLabel : UILabel!
    @IBOutlet var costLabel : UILabel!
    
    var rideJSON : JSON!
    var ridePingLocations: [JSON]!
    
    func render() {
        if let rideJ = rideJSON {
            rideID.text = "Ride id: \(rideJ["id"].stringValue)"
        } else {
            rideID.text = "Totals"
        }
        
        
    }

}
