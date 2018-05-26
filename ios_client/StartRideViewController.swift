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
    
    @IBOutlet var startButton : UIButton!
    
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
        
        addRoundingToStartButton()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addRoundingToStartButton() {
        startButton.layer.borderWidth = 2
        startButton.layer.cornerRadius =  startButton.bounds.height / 2
        startButton.layer.borderColor = UIColor.purple.cgColor
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

    @IBAction func startButtonPressed(_ sender: Any) {
        
        let inRideVC : InRideViewController = self.storyboard?.instantiateViewController(withIdentifier: "InRideViewController") as! InRideViewController
        
        inRideVC.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        
        present(inRideVC, animated: true, completion: nil)
    }
    

}
