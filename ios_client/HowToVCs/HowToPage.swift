//
//  HowToPage.swift
//  ios_client
//
//  Created by Max Dignan on 6/9/18.
//  Copyright © 2018 RideZoot. All rights reserved.
//

import Foundation
import UIKit
//import SwipeViewController
//
//class MainSwipeVC : SwipeViewController {
//    func buildList() {
//        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//
//        let firstPage : HowToZootViewController = storyboard.instantiateViewController(withIdentifier: "HowToZootViewController") as! HowToZootViewController
//
//        let secondPage : MenuViewController = storyboard.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
//
//        setViewControllerArray([firstPage, secondPage])
//        self.navigationBar.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 0)
//    }
//}
//
//class HowToPage {
//
//
//    static func makePage(sendingViewController: UIViewController) {
//        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//
//        let firstPage : HowToZootViewController = storyboard.instantiateViewController(withIdentifier: "HowToZootViewController") as! HowToZootViewController
//
//        let mainSwipePage : MainSwipeVC = MainSwipeVC(rootViewController: firstPage)
//
//        mainSwipePage.buildList()
//
//        sendingViewController.present(mainSwipePage, animated: true, completion: nil)
//    }
//}


protocol SwipeableViewControllerDelegate {
    func innerScrollViewShouldScroll() -> Bool
}

class SwipeableViewController: UIViewController {
    
    var vC: [UIViewController] = [] //This where the viewcontrollers will end up and send it to the view
    
    //Put the viewcontroller identifiers here
    let viewControllersRaw : [String] = [
        "HowToZootViewController",
        "SafetyViewController",
        "StartYourExperienceViewController",
        "BrakingViewController",
        "RidingViewController",
        "ParkingViewController",
        "EndingYourExperienceViewController",
        "EarnFreeRidesHowToViewController",
        "PleaseObeyTheLawViewController",
        "MenuViewController"
    ]
    
    var initialContentOffset = CGPoint() // scrollView initial offset
    var scrollView: UIScrollView!
    var delegate: SwipeableViewControllerDelegate?
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        for i in 0...(viewControllersRaw.count - 1) {
            
            //This changes change the instantiate view
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            
            let object = storyboard.instantiateViewController(withIdentifier: viewControllersRaw[i])
            vC.append(object)
        }
        
        setupHorizontalScrollView()
    }
    
    func setupHorizontalScrollView() {
        
        //Set some standard vars
        let cWidth = self.view.bounds.width
        let cHeight = self.view.bounds.height
        let countVC = CGFloat(vC.count)
        
        scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = false
        scrollView.delegate = self
        
        //Set the size of the frame
        self.scrollView!.frame = CGRect(x: self.view.bounds.origin.x, y: self.view.bounds.origin.y, width: cWidth, height: cHeight)
        
        
        self.view.addSubview(scrollView)
        
        let scrollWidth: CGFloat  = countVC * cWidth
        let scrollHeight: CGFloat  = cHeight
        self.scrollView!.contentSize = CGSize(width: scrollWidth, height: scrollHeight)
        
        //Loop through all views
        for i in 0...(self.vC.count - 1) {
            
            //Set the frames
            
            vC[i].view.frame = CGRect(x: CGFloat(i) * cWidth, y: 0, width: cWidth, height: cHeight)
            self.addChildViewController(vC[i])
            self.scrollView!.addSubview(vC[i].view!)
            
            if(i == self.vC.count){
                vC[i].didMove(toParentViewController: self)
            }
            
            
        }
        
        
        self.scrollView!.delegate = self;
    }
    
    
}

// MARK: UIScrollView Delegate
extension SwipeableViewController: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.initialContentOffset = scrollView.contentOffset
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if delegate != nil && !delegate!.innerScrollViewShouldScroll() {
            // This is probably crazy movement: diagonal scrolling
            var newOffset = CGPoint()
            
            if (abs(scrollView.contentOffset.x) > abs(scrollView.contentOffset.y)) {
                newOffset = CGPoint(x: self.initialContentOffset.x, y: self.initialContentOffset.y)
            } else {
                newOffset = CGPoint(x: self.initialContentOffset.x, y: self.initialContentOffset.y)
            }
            
            // Setting the new offset to the scrollView makes it behave like a proper
            // directional lock, that allows you to scroll in only one direction at any given time
            self.scrollView!.setContentOffset(newOffset,animated:  false)
        }
    }
}



