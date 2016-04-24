//
//  ViewController.swift
//  flakr
//
//  Created by Jason Ma on 4/23/16.
//  Copyright © 2016 tiffmomdotcom. All rights reserved.
//
import DrawerController
import UIKit

class ViewController: UIViewController {

    var label: UILabel?
    var username: UITextField?
    var password: UITextField?
    
    let screenSize: CGRect = UIScreen.mainScreen().bounds
    //automatically called when view is loaded
    override func viewDidLoad() {
        let jason = 1
        var sux = 2
        var list = [1,2,3]
        
        

        initializeSplashLabels()
        initializeSplashTextFields()
        initializeRegisterButton()

        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }
    
    func initializeSplashLabels() {
        label = UILabel()
        label!.frame = CGRectMake(screenSize.width/2 - 100, 2 * screenSize.height/10, 200, screenSize.height/10)
        label!.text = "flakr"
        label!.font = UIFont(name: label!.font.fontName, size: 50)
        view.addSubview(label!)
    }
    
    func initializeSplashTextFields() {
        username = UITextField()
        username!.frame = CGRectMake(screenSize.width/2 - 100, 3 * screenSize.height/10, 200, screenSize.height/10)
        username!.placeholder = "Username:"
        view.addSubview(username!)
        
        password = UITextField()
        password!.frame = CGRectMake(screenSize.width/2 - 100, 4 * screenSize.height/10, 200, screenSize.height/10)
        password!.placeholder = "Password"
        password!.secureTextEntry = true
        view.addSubview(password!)
    }
    
    func initializeRegisterButton() {
        let button: UIButton = UIButton()
        button.frame = CGRectMake(screenSize.width/2 - 100, 5 * screenSize.height/10, 100, screenSize.height/18)
        button.backgroundColor = UIColor.blueColor()
        button.setTitle("Register!", forState: UIControlState.Normal)
        button.addTarget(self, action: "register:", forControlEvents: UIControlEvents.TouchUpInside)
        view.addSubview(button)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func register(sender: AnyObject) {
        print(username!.text!)
        print(password!.text!)
        
        let vc:DashBoardViewController = (UIStoryboard(name: "Main", bundle: nil)).instantiateViewControllerWithIdentifier("Dashboard") as!DashBoardViewController
        vc.username = username!.text!
        
        let drawerCon = DrawerController(centerViewController: UINavigationController(rootViewController: vc),leftDrawerViewController: UITableViewController())

        drawerCon.openDrawerGestureModeMask = OpenDrawerGestureMode.BezelPanningCenterView
        drawerCon.closeDrawerGestureModeMask = CloseDrawerGestureMode.PanningCenterView

        self.presentViewController(drawerCon, animated: true, completion: nil)
    }


}

