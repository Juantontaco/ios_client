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
    
    func checkIfInRide(callback: @escaping (Bool) -> Void) {
        NetworkHelper().checkIfInRide(completion: { inRide in
            self.isInRide = inRide
            
            callback(self.isInRide)
        })
    }
    
    
}
