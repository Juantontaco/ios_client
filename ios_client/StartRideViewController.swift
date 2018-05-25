//
//  StartRideViewController.swift
//  ios_client
//
//  Created by Max Dignan on 5/25/18.
//  Copyright © 2018 RideZoot. All rights reserved.
//

import UIKit

class StartRideViewController: UIViewController {
    
    var scooter : Scooter! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(scooter.description)
        // Do any additional setup after loading the view.
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
