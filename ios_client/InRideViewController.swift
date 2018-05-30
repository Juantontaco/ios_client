//
//  InRideViewController.swift
//  ios_client
//
//  Created by Max Dignan on 5/26/18.
//  Copyright © 2018 RideZoot. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class InRideViewController: UIViewController {
    
    var timer = Timer()
    
    @IBOutlet var endButton : UIButton!
    
    var rideId : String?
    
    var pingTimer: Timer!
    var pingLocations: [CLLocation] = []
    var needToResume : Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        if needToResume {
            prependPreviousPingLocations()
        }
        
        showLogo()
        addVerticleGradientTopBar()
        showBlackBar(withText: "Let's Roll")
        
        setUpMap()
        
        showEndButton()
        setUpPingTimer()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if needToResume {
            toastMessage(message: "Moved Back to Current Ride!", danger: false)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        HomeViewController.mapView.clear()
    }
    
    func setUpMap() {
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { t in
            
            self.updateLocation()
        })
        GMSServices.provideAPIKey("AIzaSyClvCSMOHd4s_0-RywvjMn7yPVjv-mEzAo")
        
        GMSPlacesClient.provideAPIKey("AIzaSyClvCSMOHd4s_0-RywvjMn7yPVjv-mEzAo")
        
        
        var camera = GMSCameraPosition.camera(withLatitude: 40.0, longitude: -83.0, zoom: 14.0)
        
        if let currentCoordinate = LocationHelper.shared?.currentLocation?.coordinate {
            
            camera = GMSCameraPosition.camera(withLatitude: currentCoordinate.latitude, longitude: currentCoordinate.longitude, zoom: 14.0)
            
        }
        
        let heightOffset : CGFloat = 100.0
        
        if HomeViewController.mapView == nil {
            HomeViewController.mapView = GMSMapView.map(withFrame: CGRect(x: 0, y: heightOffset, width: self.view.bounds.width, height: self.view.bounds.height - heightOffset), camera: camera)
            
            
        }
        
        
        HomeViewController.mapView.clear()
        HomeViewController.mapView.isMyLocationEnabled = true
        
        view.addSubview(HomeViewController.mapView)
        
    }
    
    func showEndButton() {
        endButton.layer.borderWidth = 2
        endButton.layer.cornerRadius =  endButton.bounds.height / 2
        endButton.layer.borderColor = UIColor.purple.cgColor
        
        endButton.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        
        view.bringSubview(toFront: endButton)
    }
    
    func updateLocation() {
        let currentCoordinate = LocationHelper.shared?.currentLocation?.coordinate
        
        var latitude = currentCoordinate?.latitude
        
        if latitude == nil {
            latitude = -100
        }
        
        var longitude = currentCoordinate?.longitude
        
        if longitude == nil {
            longitude = -100
        }
        
        
        
        
        
        if let mv = HomeViewController.mapView {
            HomeViewController.mapView.isMyLocationEnabled = true
            let camera = GMSCameraPosition.camera(withLatitude: latitude!, longitude: longitude!, zoom: mv.camera.zoom)
            mv.animate(to: camera)
            
            timer.invalidate()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func endButtonPressed(_ sender: Any) {
        
        
        
        NetworkHelper().endRide(rideId: self.rideId!, completion: { (rideDictionary : NSDictionary?, cost: Double?) in
            
            if rideDictionary != nil && cost != nil {
                self.destructPingTimer()
                
                self.goToRideSummaryVC(cost: cost!)
                
            } else {
                self.toastMessage(message: "There was an error ending the ride.", danger: true)
            }
        })
    }
    
    func setUpPingTimer() {
        self.pingTimer = Timer.scheduledTimer(withTimeInterval: 10.0, repeats: true, block: { t in
            
            self.pingLocation()
        })
    }
    
    func destructPingTimer() {
        self.pingTimer.invalidate()
        self.pingTimer = nil
    }
    
    func pingLocation() {
        if let currLocation : CLLocation = LocationHelper.shared.currentLocation {
            
            HomeViewController.mapView.animate(toLocation: currLocation.coordinate)
            pingLocations.append(currLocation)
            markLocationsOnMap()
            
            NetworkHelper().pingRide(rideId: rideId!, latitude: currLocation.coordinate.latitude, longitude: currLocation.coordinate.longitude, completion: { didWork in
                
                if didWork {
                    print("location pinged")
                } else {
                    print("Problem getting current location to ping - in response")
                }
            })
        } else {
            print("Problem getting current location to ping")
        }
    }
    
    func markLocationsOnMap() {
        HomeViewController.mapView.clear()
        
        let path = GMSMutablePath()
        
        pingLocations.forEach { (location) in
            path.add(location.coordinate)
        }
        
        let polyline = GMSPolyline(path: path)
        polyline.strokeColor = UIColor(red:0.67, green:0.33, blue:0.79, alpha:1.0)
        polyline.strokeWidth = 5
        polyline.map = HomeViewController.mapView
    }
    
    func prependPreviousPingLocations() {
        NetworkHelper().getRide(rideId: rideId!, completion: { rideDictionary, incPingLocations in
            
            if incPingLocations != nil {
                incPingLocations!.forEach({ pingLocationJSON in
                    
                    let loc : CLLocation = CLLocation(latitude: CLLocationDegrees(exactly: pingLocationJSON["latitude"].doubleValue)!, longitude: CLLocationDegrees(exactly: pingLocationJSON["longitude"].doubleValue)!)
                    
                    self.pingLocations.insert(loc, at: 0)
                })
                
                self.markLocationsOnMap()
            } else {
                print("There was an error receiving old ping locations from server")
            }
            })
    }
    
    func goToRideSummaryVC(cost: Double) {
        let rideSummaryVC : RideSummaryViewController = self.storyboard?.instantiateViewController(withIdentifier: "RideSummaryViewController") as! RideSummaryViewController
        
        rideSummaryVC.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        
        rideSummaryVC.cost = cost
        rideSummaryVC.scooterId = "NA now"
        rideSummaryVC.rideId = self.rideId
        
        present(rideSummaryVC, animated: true, completion: nil)
    }
}
