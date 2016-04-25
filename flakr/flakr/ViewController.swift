//
//  ViewController.swift
//  flakr
//
//  Created by Jason Ma on 4/23/16.
//  Copyright © 2016 tiffmomdotcom. All rights reserved.
//
import DrawerController
import UIKit
import Firebase

class ViewController: UIViewController {

    var label: UILabel?
    var usernameField: UITextField?
    var passwordField: UITextField?
    var myRootRef = Firebase(url:"https://incandescent-heat-1881.firebaseio.com/")
    
    let screenSize: CGRect = UIScreen.mainScreen().bounds
    //automatically called when view is loaded
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.whiteColor()
        
        let backgroundImage = UIImageView(frame: UIScreen.mainScreen().bounds)
        backgroundImage.image = UIImage(named: "flaked")
        backgroundImage.alpha = 0.5
        self.view.insertSubview(backgroundImage, atIndex: 0)
        
//        self.view.backgroundColor = UIColor.cyanColor()
        initializeSplashLabels()
        initializeSplashTextFields()
        initializeRegisterButton()

        
        super.viewDidLoad()
        
        
        myRootRef.setValue("LOL HOW DOES THIS WORK")
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
        usernameField = UITextField()
        usernameField!.frame = CGRectMake(screenSize.width/2 - 100, screenSize.height * 0.3, 200, screenSize.height * 0.045)
        usernameField!.placeholder = "Username:"
        usernameField!.backgroundColor = UIColor.cyanColor()
        view.addSubview(usernameField!)
        
        passwordField = UITextField()
        passwordField!.frame = CGRectMake(screenSize.width/2 - 100, screenSize.height * 0.37, 200, screenSize.height * 0.045)
        passwordField!.placeholder = "Password"
        passwordField!.secureTextEntry = true
        passwordField!.backgroundColor = UIColor.cyanColor()
        view.addSubview(passwordField!)
    }
    
    func initializeRegisterButton() {
        let button: UIButton = UIButton()
        button.frame = CGRectMake(screenSize.width/2 - 114, screenSize.height * 0.44, 100, screenSize.height * 0.045)
//        button.backgroundColor = UIColor.blueColor()
        button.setTitle("Register!", forState: UIControlState.Normal)
        button.addTarget(self, action: "register:", forControlEvents: UIControlEvents.TouchUpInside)
        button.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        view.addSubview(button)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    func register(sender: AnyObject) {
//        let username = usernameField!.text
//        let email = usernameField!.text
//        let password = passwordField!   .text
//        
//        if username != "" && email != "" && password != "" {
//            
//            // Set Email and Password for the New User.
//            
//            DataService.dataService.BASE_REF.createUser(email, password: password, withValueCompletionBlock: { error, result in
//                
//                if error != nil {
//                    
//                    // There was a problem.
//                    self.signupErrorAlert("Oops!", message: "Having some trouble creating your account. Try again.")
//                    
//                } else {
//                    
//                    // Create and Login the New User with authUser
//                    DataService.dataService.BASE_REF.authUser(email, password: password, withCompletionBlock: {
//                        err, authData in
//                        
//                        let user = ["provider": authData.provider!, "email": email!, "username": username!]
//                        
//                        // Seal the deal in DataService.swift.
//                        DataService.dataService.createNewAccount(authData.uid, user: user)
//                    })
//                    
//                    // Store the uid for future access - handy!
//                    NSUserDefaults.standardUserDefaults().setValue(result ["uid"], forKey: "uid")
//                    
//                    // Enter the app.
//                    let vc:DashBoardViewController = (UIStoryboard(name: "Main", bundle: nil)).instantiateViewControllerWithIdentifier("Dashboard") as!DashBoardViewController
//                    
//                    vc.username = self.usernameField!.text!
//                    
//                    let menuTable = MenuTableViewController()
//                    
//                    menuTable.dashboardVC = vc;
//                    
//                    let drawerCon = DrawerController(centerViewController: UINavigationController(rootViewController: vc),leftDrawerViewController: menuTable)
//                    
//                    drawerCon.openDrawerGestureModeMask = OpenDrawerGestureMode.BezelPanningCenterView
//                    drawerCon.closeDrawerGestureModeMask = CloseDrawerGestureMode.PanningCenterView
//                    
//                    self.presentViewController(drawerCon, animated: true, completion: nil)
//                }
//            })
//            
//        } else {
//            signupErrorAlert("Oops!", message: "Don't forget to enter your email, password, and a username.")
//        }
//        
//    }

    func signupErrorAlert(title: String, message: String) {
        
        // Called upon signup error to let the user know signup didn't work.
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }
    
    func register(sender: AnyObject) {
        print(usernameField!.text!)
        print(passwordField!.text!)
        myRootRef.createUser(usernameField!.text, password: passwordField!.text,
                             withValueCompletionBlock: { error, result in
                                if error != nil {
                                    print("fuck")
                                    // There was an error creating the account
                                } else {
                                    let uid = result["uid"] as? String
                                    print("Successfully created user account with uid: \(uid)")
                                }
        })
        
        let vc:DashBoardViewController = (UIStoryboard(name: "Main", bundle: nil)).instantiateViewControllerWithIdentifier("Dashboard") as!DashBoardViewController
        
        vc.username = usernameField!.text!
        
        let menuTable = MenuTableViewController()
        
        menuTable.dashboardVC = vc;
        
        let drawerCon = DrawerController(centerViewController: UINavigationController(rootViewController: vc),leftDrawerViewController: menuTable)

        drawerCon.openDrawerGestureModeMask = OpenDrawerGestureMode.BezelPanningCenterView
        drawerCon.closeDrawerGestureModeMask = CloseDrawerGestureMode.PanningCenterView
        
        self.presentViewController(drawerCon, animated: true, completion: nil)
    }


}

