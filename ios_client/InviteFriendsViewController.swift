//
//  InviteFriendsViewController.swift
//  ios_client
//
//  Created by Max Dignan on 6/1/18.
//  Copyright © 2018 RideZoot. All rights reserved.
//

import UIKit

class InviteFriendsViewController: UIViewController {

    @IBOutlet var sendFreeRidesButton : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showMenu()
        
        self.sendFreeRidesButton.addPurpleBorder()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sendFreeRidesButtonPressed(_ sender: Any) {
    }
    
}
