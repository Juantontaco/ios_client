//
//  StartRideViewController.swift
//  ios_client
//
//  Created by Max Dignan on 5/25/18.
//  Copyright © 2018 RideZoot. All rights reserved.
//

import UIKit

class StartRideViewController: UIViewController {
    
    @IBOutlet var scooterView : UIView!
    @IBOutlet var idValLabel : UILabel!
    @IBOutlet var batteryLabel : UILabel!
    
    var scooter : Scooter! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(scooter.description)
        // Do any additional setup after loading the view.
        
        setUpBorder()
        fillInLabels()
        
        addVerticleGradientTopBar()
        showLogo()
        showMenu()
        showBlackBar(withText: "Let's Roll")
        
        showWhiteBelowBlackBar()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpBorder() {
        scooterView?.backgroundColor = .white
        scooterView?.layer.borderColor = UIColor.purple.cgColor
        scooterView?.layer.borderWidth = 2
        scooterView?.layer.cornerRadius = 10
    }
    
    func fillInLabels() {
        idValLabel.text = scooter.specialIDCode.uppercased()
        
        batteryLabel.text = "\(scooter.battery!)%"
    }
    
    func showWhiteBelowBlackBar() {
        
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
