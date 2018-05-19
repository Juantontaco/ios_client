//
//  HomeViewController.swift
//  ios_client
//
//  Created by Max Dignan on 5/19/18.
//  Copyright © 2018 RideZoot. All rights reserved.
//

import UIKit
import Locksmith

class HomeViewController: UIViewController {

    @IBOutlet weak var showUID: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        let dictionary = Locksmith.loadDataForUserAccount(userAccount: "user")
        
        showUID.text = dictionary?["uid"] as? String
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logoutPressed(_ sender: Any) {
        
        do {
            try Locksmith.deleteDataForUserAccount(userAccount: "user")
        } catch {
            print("Error deleting info")
        }
        
        
        let loginViewController = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController
        
        self.navigationController?.setViewControllers([loginViewController!], animated: false)
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
