////
////  DashBoardViewController.swift
////  flakr
////
////  Created by Jason Ma on 4/24/16.
////  Copyright © 2016 tiffmomdotcom. All rights reserved.
////
//

import UIKit

class MakeAnEventViewController: UIViewController {
    var label: UILabel?
    let screenSize: CGRect = UIScreen.mainScreen().bounds
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Rate this bitch"
        self.view.backgroundColor = UIColor.whiteColor()
    }
    
    func initializeSplashLabels() {
        label = UILabel()
        label!.frame = CGRectMake(screenSize.width/2 - 100, 2 * screenSize.height/10, 200, screenSize.height/10)
        label!.text = "flakr"
        label!.font = UIFont(name: label!.font.fontName, size: 50)
        view.addSubview(label!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

