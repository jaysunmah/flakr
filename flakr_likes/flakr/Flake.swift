//
//  Flake.swift
//  flakr
//
//  Created by Jason Ma on 4/25/16.
//  Copyright © 2016 tiffmomdotcom. All rights reserved.
//

import Foundation
import Firebase

class Flake {
    private var _flakeRef: Firebase!
    
    private var _flakeKey: String!
    private var _flakeReason: String!
    private var _flakeFlaker: String!
    private var _flakeFlakee: String!
    private var _flakeLikes: [String]!
    
    var flakeKey: String {
        return _flakeKey
    }
    
    var flakeReason: String {
        return _flakeReason
    }
    
    var flakeFlaker: String {
        return _flakeFlaker
    }
    
    var flakeFlakee: String {
        return _flakeFlakee
    }
    var flakeLikes: [String] {
        return _flakeLikes
    }
    
    // Initialize the new Joke
    
    init(key: String, dictionary: Dictionary<String, AnyObject>) {
        self._flakeKey = key
        
        // Within the Joke, or Key, the following properties are children
        
        if let flaker = dictionary["flaker"] as? String {
            self._flakeFlaker = flaker
        }
        
        if let flakee = dictionary["flakee"] as? String {
            self._flakeFlakee = flakee
        }
        
        if let likes = dictionary["likes"] as? [String] {
            self._flakeLikes = likes
        } else {
            self._flakeLikes = ["nil"]
        }
        
        if let reason = dictionary["reason"] as? String {
            self._flakeReason = reason
        } else {
            self._flakeReason = ""
        }
        
        // The above properties are assigned to their key.
        
        self._flakeRef = DataService.dataService.FLAKE_REF.childByAppendingPath(self._flakeKey)
    }
}