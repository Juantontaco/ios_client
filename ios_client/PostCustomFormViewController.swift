//
//  PostCustomFormViewController.swift
//  ios_client
//
//  Created by Max Dignan on 6/1/18.
//  Copyright © 2018 RideZoot. All rights reserved.
//

import UIKit

class PostCustomFormViewController: UIViewController {
    
    @IBOutlet var label : UILabel!
    @IBOutlet var imageView : UIImageView!
    
    var isForCharger = false
    var isForHelmet  = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addVerticalGradient()
        showLogo()
        showMenu()

        if isForCharger {
            writeCharger()
        } else if isForHelmet {
            writeHelmet()
        }
    }
    
    func writeCharger() {
        label.text = "Awesome!\nYour Zooter chargers will arrive at your place within 5 business days.\nRemember, you can charge whenever you find a dead Zooter or when we send you a notification.\nThanks for participating!\nLet’s Roll"
        
        imageView.image = UIImage(named: "charger icon")
    }
    
    func writeHelmet() {
        label.text = "Awesome!\nA Zooter helmet will arrive at your place within 5 business days.\nPlease wear a helmet whenever you ride a Zooter.\nLet’s Roll"
        
        imageView.image = UIImage(named: "helmet icon")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
