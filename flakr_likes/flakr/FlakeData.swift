//
//  FlakeData.swift
//  flakr
//
//  Created by Jason Ma on 4/24/16.
//  Copyright © 2016 tiffmomdotcom. All rights reserved.
//

import Foundation

class FlakeData {
    var flaker: String
    var flakee: String
    var timeStamp: Int
    var reason: String
    init(flaker: String, flakee: String, timeStamp: Int, reason: String) {
        self.flaker = flaker
        self.flakee = flakee
        self.timeStamp = timeStamp
        self.reason = reason
    }
    
}