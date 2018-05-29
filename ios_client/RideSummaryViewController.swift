//
//  RideSummaryViewController.swift
//  ios_client
//
//  Created by Max Dignan on 5/28/18.
//  Copyright © 2018 RideZoot. All rights reserved.
//

import UIKit

class RideSummaryViewController: UIViewController {
    
    @IBOutlet var costLabel : UILabel!
    @IBOutlet var rideIdLabel : UILabel!
    @IBOutlet var scooterIdLabel : UILabel!
    
    var rideId    : String!
    var cost      : Double!
    var scooterId : String!

    override func viewDidLoad() {
        super.viewDidLoad()

        showRide()
        showLogo()
        showMenu()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showRide() {
        costLabel.text = "\(cost!)"
        rideIdLabel.text = rideId
        scooterIdLabel.text = scooterId
    }

}
