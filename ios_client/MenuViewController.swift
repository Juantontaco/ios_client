//
//  MenuViewController.swift
//  ios_client
//
//  Created by Max Dignan on 5/19/18.
//  Copyright © 2018 RideZoot. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    @IBOutlet weak var earnFreeRidesButton : UIButton!
    @IBOutlet weak var chargeZootersButton : UIButton!
    @IBOutlet weak var requestHelmetButton : UIButton!
    @IBOutlet weak var accountButton : UIButton!
    @IBOutlet weak var paymentButton : UIButton!
    @IBOutlet weak var howToButton : UIButton!
    @IBOutlet weak var safetyButton : UIButton!
    @IBOutlet weak var historyButton : UIButton!
    @IBOutlet weak var settingsButton : UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addVerticalGradient()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
