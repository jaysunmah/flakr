//
//  FlakeData.swift
//  flakr
//
//  Created by Jason Ma on 4/24/16.
//  Copyright © 2016 tiffmomdotcom. All rights reserved.
//

import Foundation

class Client {
    var username: String
    var password: String
    var history: [String]
    var photo: String
    var start: String
    var flakes: Int
    
    
    init(username: String, password: String, history: [String], photo: String, start: String, flakes: Int) {
        self.username = username
        self.password = password
        self.history = history
        self.photo = photo
        self.start = start
        self.flakes = flakes
    }
    
}