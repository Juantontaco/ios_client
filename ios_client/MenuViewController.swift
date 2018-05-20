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
        showLogo()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func homePressed(_ sender: Any) {}
    @IBAction func earnFreeRidesPressed(_ sender: Any) {}
    @IBAction func chargeZootersPressed(_ sender: Any) {}
    @IBAction func requestHelmetPressed(_ sender: Any) {}
    
    @IBAction func accountPressed(_ sender: Any) {

        let accountViewController : AccountViewController = self.storyboard?.instantiateViewController(withIdentifier: "AccountViewController") as! AccountViewController
        
        self.navigationController?.setViewControllers([accountViewController], animated: true)
    }
    
    @IBAction func paymentPressed(_ sender: Any) {}
    @IBAction func howToPressed(_ sender: Any) {}
    @IBAction func safetyPressed(_ sender: Any) {}
    @IBAction func historyPressed(_ sender: Any) {}
    @IBAction func settingsPressed(_ sender: Any) {}
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
