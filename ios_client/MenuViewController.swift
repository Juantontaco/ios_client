//
//  MenuViewController.swift
//  ios_client
//
//  Created by Max Dignan on 5/19/18.
//  Copyright © 2018 RideZoot. All rights reserved.
//

import UIKit
import Onboard

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
    
    @IBAction func homePressed(_ sender: Any) {
        let homeViewController : HomeViewController = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        
        homeViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        
        self.present(homeViewController, animated: true, completion: nil)
    }
    
    @IBAction func zafarisButtonPressed(_ sender: Any) {
        
        self.toastMessage(message: "Zafaris are not available yet! Check back soon!", danger: false)
    }
    
    
    @IBAction func earnFreeRidesPressed(_ sender: Any) {
        let inviteFriendsVC : InviteFriendsViewController = self.storyboard?.instantiateViewController(withIdentifier: "InviteFriendsViewController") as! InviteFriendsViewController
        
        inviteFriendsVC.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        
        present(inviteFriendsVC, animated: true, completion: nil)
    }
    @IBAction func chargeZootersPressed(_ sender: Any) {
        let chargerVC : CustomFormViewController = self.storyboard?.instantiateViewController(withIdentifier: "CustomFormViewController") as! CustomFormViewController
        chargerVC.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        chargerVC.isForCharger = true
        chargerVC.isForHelment = false
        
        present(chargerVC, animated: true, completion: nil)
    }
    @IBAction func requestHelmetPressed(_ sender: Any) {
        let chargerVC : CustomFormViewController = self.storyboard?.instantiateViewController(withIdentifier: "CustomFormViewController") as! CustomFormViewController
        chargerVC.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        chargerVC.isForCharger = false
        chargerVC.isForHelment = true
        
        present(chargerVC, animated: true, completion: nil)
    }
    
    @IBAction func accountPressed(_ sender: Any) {

        let accountViewController : AccountViewController = self.storyboard?.instantiateViewController(withIdentifier: "AccountViewController") as! AccountViewController
        accountViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        
        
        self.present(accountViewController, animated: true, completion: nil)
    }
    
    @IBAction func paymentPressed(_ sender: Any) {
        
        let paymentSourcesVC : PaymentSourcesViewController = self.storyboard?.instantiateViewController(withIdentifier: "PaymentSourcesViewController") as! PaymentSourcesViewController
        
        paymentSourcesVC.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        
        present(paymentSourcesVC, animated: true, completion: nil)
    }
    
    @IBAction func howToPressed(_ sender: Any) {
        HowToPage.makePage(sendingViewController: self)
    }
    
    @IBAction func safetyPressed(_ sender: Any) {}
    @IBAction func historyPressed(_ sender: Any) {
        let historyVC : HistoryViewController = self.storyboard?.instantiateViewController(withIdentifier: "HistoryViewController") as! HistoryViewController
        
        historyVC.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        
        present(historyVC, animated: true, completion: nil)
    }
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
