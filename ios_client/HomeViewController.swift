//
//  HomeViewController.swift
//  ios_client
//
//  Created by Max Dignan on 5/20/18.
//  Copyright © 2018 RideZoot. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class HomeViewController: UIViewController {

    static var mapView : GMSMapView!
    var timer = Timer()
    var scooters: [Scooter]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showLogo()
        showMenu()
        addVerticalGradient()
        showBlackBar(withText: "$1 to start + $0.15 per minute")
        
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
        
        
        HomeViewController.mapView.isMyLocationEnabled = true
        
        view.addSubview(HomeViewController.mapView)
        
        addInScooters()
        // Do any additional setup after loading the view.
    }
    
    deinit {
        self.scooters = nil
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addInScooters() {
        NetworkHelper().getScooters(completion: { scooters in
            self.scooters = scooters
            self.scooters.forEach({ scooter in
                let marker = GMSMarker()
                marker.position = CLLocationCoordinate2D(latitude: scooter.latitude, longitude: scooter.longitude)
                
                var icon = #imageLiteral(resourceName: "zoot locator pin 1")
                
                icon = icon.resizeImage(newWidth: 18.0)
                
                marker.icon = icon
                marker.map = HomeViewController.mapView
            })
        })
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
