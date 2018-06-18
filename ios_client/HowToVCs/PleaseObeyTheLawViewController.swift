//
//  PleaseObeyTheLawViewController.swift
//  ios_client
//
//  Created by Max Dignan on 6/12/18.
//  Copyright © 2018 RideZoot. All rights reserved.
//

import UIKit

class PleaseObeyTheLawViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        addVerticalGradient()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func goHomeButtonPressed(_ sender: Any) {
        
        let homeVC : HomeViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        
        homeVC.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        
        present(homeVC, animated: true, completion: nil)
    }
    

}
