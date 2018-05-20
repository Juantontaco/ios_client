//
//  AddedExtensions.swift
//  ios_client
//
//  Created by Max Dignan on 5/20/18.
//  Copyright © 2018 RideZoot. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    func addBorder() {
        layer.borderWidth = 2
        layer.cornerRadius = 15
        layer.borderColor = UIColor.white.cgColor
    }
}
