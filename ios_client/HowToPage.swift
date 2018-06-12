//
//  HowToPage.swift
//  ios_client
//
//  Created by Max Dignan on 6/9/18.
//  Copyright © 2018 RideZoot. All rights reserved.
//

import Foundation
import UIKit
import Onboard

class HowToPage {
    
    
    static func makePage(sendingViewController: UIViewController) {
        //First page
        let findAndUnlock = OnboardingContentViewController(title: "Find and Unlock", body: "Find a nearby Zooter, and tap the start button to unlock.", image: UIImage(named: "lock")?.resizeImage(newWidth: sendingViewController.view.bounds.width / 3), buttonText: nil, action: nil)
        
        findAndUnlock.topPadding = 100.0
        findAndUnlock.bodyLabel.sizeToFit()
        
        //Second page
        let safetyPage = OnboardingContentViewController(title: "Safety", body: "Always wear a helmet while riding.", image: UIImage(named: "helmet icon")?.resizeImage(newWidth: sendingViewController.view.bounds.width / 3), buttonText: nil, action: nil)
        
        safetyPage.topPadding = 100.0
        safetyPage.bodyLabel.sizeToFit()
        
        //Third Page
        let startPage = OnboardingContentViewController(title: "Start Your Experience", body: "Kick start three times\nThen push the throttle with your right thumb", image: UIImage(named: ""), buttonText: nil, action: nil)
        
        //Final Setup
        let onboardVC : OnboardingViewController = OnboardingViewController(backgroundImage: nil, contents: [findAndUnlock, safetyPage])
        
        onboardVC.shouldMaskBackground = false
        
        onboardVC.showLogo()
        onboardVC.showMenu()
        onboardVC.addVerticalGradient()
        
        onboardVC.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        
        sendingViewController.present(onboardVC, animated: true, completion: nil)
    }
}
