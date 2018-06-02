//
//  HistoryViewController.swift
//  ios_client
//
//  Created by Max Dignan on 5/30/18.
//  Copyright © 2018 RideZoot. All rights reserved.
//

import UIKit
import SwiftyJSON
import GoogleMaps
import GooglePlaces

class HistoryViewController: UIViewController, GMSMapViewDelegate {
    
    @IBOutlet var specialView : UIView!
    
    @IBOutlet var rideIdLabel : UILabel!
    @IBOutlet var distanceLabel : UILabel!
    @IBOutlet var timeLabel : UILabel!
    @IBOutlet var costLabel : UILabel!
    
    var ridesWithRidePingLocations : [JSON]?
    var timer : Timer!

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpMap()
        addVerticleGradientTopBar()
        showLogo()
        showMenu()
        showBlackBar(withText: "Ride History")
        
        getRidesWithRidePingLocations()
        makeSpecialViewDefault()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getRidesWithRidePingLocations() {
        NetworkHelper().getAllMyRides { arrayOfRidesWithRidePingLocations in
            if arrayOfRidesWithRidePingLocations != nil {
                self.ridesWithRidePingLocations = arrayOfRidesWithRidePingLocations
                
                self.drawRidesToMap()
            } else {
                self.toastMessage(message: "Error Occurred Retrieving History", danger: true)
            }
        }
    }
    
    func drawRidesToMap() {
        HomeViewController.mapView.clear()
        self.ridesWithRidePingLocations?.forEach({ (rideWithRidePingLocation) in
            

            
            let path = GMSMutablePath()
            rideWithRidePingLocation["ride_ping_locations"].array?.forEach({ (pingLocationJSON) in
                
                let loc : CLLocation = CLLocation(latitude: CLLocationDegrees(exactly: pingLocationJSON["latitude"].doubleValue)!, longitude: CLLocationDegrees(exactly: pingLocationJSON["longitude"].doubleValue)!)
                
                path.add(loc.coordinate)
            })
            
            let polyline = GMSPolyline(path: path)
            polyline.strokeColor = UIColor(red:0.67, green:0.33, blue:0.79, alpha:1.0)
            polyline.strokeWidth = 5
            
            polyline.userData = (rideWithRidePingLocation["ride"], rideWithRidePingLocation["calculated_cost"].double, rideWithRidePingLocation["ride_ping_locations"].array)
            
            polyline.isTappable = true
            
            polyline.map = HomeViewController.mapView

        })
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
        HomeViewController.mapView.delegate = self
        
        view.addSubview(HomeViewController.mapView)
        
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
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        
        makeSpecialViewDefault()
    }
    
    func mapView(_ mapView: GMSMapView, didTap overlay: GMSOverlay) {
        let rideWithCost : (JSON, Double?, [JSON]?) = overlay.userData as! (JSON, Double?, [JSON]?)
        
        print(rideWithCost.0)
        print(rideWithCost.1)
        print(rideWithCost.2)
        
        showSpecialView(incomingRideWithCost: rideWithCost)
    }
    
    func makeSpecialViewDefault() {
        self.view.bringSubview(toFront: self.specialView)
        self.specialView.layer.borderColor = UIColor.purple.cgColor
        self.specialView.layer.borderWidth = 2
        self.specialView.layer.cornerRadius = 10
        
        self.rideIdLabel.text = "Totals"
    }
    
    func showSpecialView(incomingRideWithCost: (JSON, Double?, [JSON]?)?) {
        
        if incomingRideWithCost != nil {
            self.rideIdLabel.text = "Ride ID: \(incomingRideWithCost!.0["id"])"
            self.distanceLabel.text = "Distance: \(RideHelper().calculateRideDistance(ridePingLocations: (incomingRideWithCost?.2)!))"
            
            //time label
            self.timeLabel.text = "Time: \(RideHelper().elapsedTime(ride: incomingRideWithCost!.0))"
            
            self.costLabel.text = String(format: "Trip Cost: $%.02f", incomingRideWithCost!.1! / 100)
            
            self.view.addSubview(specialView)
        } else {
            
        }
    }

}
