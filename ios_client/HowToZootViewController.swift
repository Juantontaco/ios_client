//
//  HowToZootViewController.swift
//  ios_client
//
//  Created by Max Dignan on 6/1/18.
//  Copyright © 2018 RideZoot. All rights reserved.
//

import UIKit
import Onboard

class HowToZootViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addVerticalGradient()
        showMenu()
        showLogo()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    static func buildWithOnboardLib() -> OnboardingViewController? {
        let firstPage = OnboardingContentViewController(title: "Find and Unlock", body: "Find a nearby Zooter and tap the start button to unlock.", image: UIImage(named: "safety icon"), buttonText: "Next", action: nil)
        
        let onboardVC = OnboardingViewController(backgroundImage: nil, contents: [firstPage])
        
        onboardVC?.addVerticalGradient()
        onboardVC?.showLogo()
        onboardVC?.showMenu()
        
        return onboardVC
    }

}
