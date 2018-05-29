//
//  RideHelper.swift
//  ios_client
//
//  Created by Max Dignan on 5/22/18.
//  Copyright © 2018 RideZoot. All rights reserved.
//

import Foundation


class RideHelper {
    
    static let shared: RideHelper! = {
        return RideHelper()
    }()
    
    var isInRide : Bool = false
    var rideId : String!
    
    func checkIfInRide(callback: @escaping (Bool, String) -> Void) {
        NetworkHelper().checkIfInRide(completion: { inRide, ride_id in
            self.isInRide = inRide
            self.rideId = ride_id
            
            callback(self.isInRide, ride_id)
        })
    }
    
    
}
