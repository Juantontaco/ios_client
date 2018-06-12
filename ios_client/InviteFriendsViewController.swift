//
//  InviteFriendsViewController.swift
//  ios_client
//
//  Created by Max Dignan on 6/1/18.
//  Copyright © 2018 RideZoot. All rights reserved.
//

import UIKit
import Locksmith

class InviteFriendsViewController: UIViewController {

    @IBOutlet var sendFreeRidesButton : UIButton!
    
    @IBOutlet var redeemFreeRidesButton : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showMenu()
        
        self.sendFreeRidesButton.addPurpleBorder()

        self.redeemFreeRidesButton.addPurpleBorder()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sendFreeRidesButtonPressed(_ sender: Any) {
        
        let dictionary = Locksmith.loadDataForUserAccount(userAccount: "user")
        
        if dictionary != nil {
            let email : String = dictionary!["uid"] as! String
            
            let shareText = "Hey, you get a free ride with Zoot by redeeming my email. Simply download the app and redeem on the Earn Free Rides page with this email: \(email)"
            let url : NSURL = NSURL(string: "https://www.ridezoot.com")!
            
            let activityVC : UIActivityViewController = UIActivityViewController(activityItems: [shareText, url], applicationActivities: nil)
            
            self.present(activityVC, animated: true)
        } else {
            toastMessage(message: "An issue occured trying to share with friends", danger: true)
        }
    }
    
    @IBAction func redeemFreeRidesPressed(_ sender: Any) {
        
        let alertController = UIAlertController(title: "Enter Promo Code", message: "Enter your friend's email as the promo code!", preferredStyle: .alert)
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Enter email..."
            textField.keyboardType = UIKeyboardType.emailAddress
        }
        
        let confirmAction = UIAlertAction(title: "Redeem", style: .default) { (_) in

            let email = alertController.textFields?[0].text
            
            print(email!)
            
            NetworkHelper().redeemPromo(email: email!, completion: { (didWork) in
                if didWork {
                    self.toastMessage(message: "Promo Redeemed", danger: false)
                } else {
                    self.toastMessage(message: "You have either already redeemed a promo or there was an error redeeming promo.", danger: true)
                }
            })
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
}
