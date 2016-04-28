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

        

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    override func shouldAutorotate() -> Bool {
        return false
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Portrait
    }
    
    
    var label: UILabel?
    var photoLabel: UILabel?
    
    var usernameField: UITextField?
    var passwordField: UITextField?
    var user_icon: UIImageView = UIImageView()
    
    var clientRef = Firebase(url:"https://incandescent-heat-1881.firebaseio.com/users")
    
    let date = NSDate();
    
    var formatter = NSDateFormatter();
    
    var startDate: String?
    
    
    
    
    let screenSize: CGRect = UIScreen.mainScreen().bounds
    
    var defaultPic: UIImageView = UIImageView()
    let imagePicker = UIImagePickerController()
    
    let sdate:NSDate = NSDate()
    
    //automatically called when view is loaded
    override func viewDidLoad() {
//        self.view.backgroundColor = UIColor.whiteColor()
        
        let backgroundImage = UIImageView(frame: UIScreen.mainScreen().bounds)
        backgroundImage.image = UIImage(named: "flakr_white_bg")
        backgroundImage.alpha = 0.9
        self.view.insertSubview(backgroundImage, atIndex: 0)
        
//        self.view.backgroundColor = UIColor.cyanColor()
        initializeSplashLabels()
        initializeSplashTextFields()
        initializeRegisterButton()
        
        


        
        super.viewDidLoad()
        
        imagePicker.delegate = self
        
        let default_icon: UIImage = UIImage(named: "profile")!
        
        defaultPic = UIImageView(image: default_icon)
        defaultPic.frame = CGRect(x: screenSize.width * 0.5 - screenSize.height * 0.06, y: screenSize.height * 0.44, width: screenSize.height * 0.12, height: screenSize.height * 0.12)
        defaultPic.layer.cornerRadius = defaultPic.frame.size.height / 2
        defaultPic.layer.masksToBounds = true
        defaultPic.layer.borderWidth = 0;
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:Selector("loadImageButtonTapped:"))
        defaultPic.userInteractionEnabled = true
        defaultPic.addGestureRecognizer(tapGestureRecognizer)
        self.view.addSubview(defaultPic)
        

        formatter .dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        startDate = formatter.stringFromDate(date);
        

//        print(startDate)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

    func encodeImageToString(image: UIImage)->String {
        //Use image name from bundle to create NSData
        //Now use image to create into NSData format
        let imageData = UIImagePNGRepresentation(image)
        let base64String = imageData!.base64EncodedStringWithOptions(.Encoding64CharacterLineLength)
        return base64String
    }
    
    func decodeStringToImage(something: String)->UIImage {
        let decodedData = NSData(base64EncodedString: something, options: NSDataBase64DecodingOptions.IgnoreUnknownCharacters)
        let newImage: UIImage = UIImage(data: decodedData!)!
        return newImage
    }
    
    func initializeSplashLabels() {
        label = UILabel()
        label!.frame = CGRectMake(screenSize.width/2 - 100, 2 * screenSize.height/10, 200, screenSize.height/10)
        label!.text = "flakr"
        label!.textColor = UIColor.blackColor()
        label!.font = UIFont(name: label!.font.fontName, size: 50)
        view.addSubview(label!)
        
        
        photoLabel = UILabel()
//        photoLabel!.backgroundColor = UIColor.cyanColor()
//        photoLabel!.alpha = 0.7
        photoLabel!.frame = CGRectMake(screenSize.width * 0.5 - 100, screenSize.height * 0.57,
                                       200, screenSize.height * 0.085)
        photoLabel!.text = "Pick a profile picture! Already a user? Just leave this blank!"
        photoLabel!.textColor = UIColor.blackColor()
        photoLabel!.numberOfLines = -1
//        photoLabel!.alpha = 0.8
        photoLabel!.font = UIFont(name: photoLabel!.font.fontName, size: 15)
        
        view.addSubview(photoLabel!)
    }
    
    func initializeSplashTextFields() {
        usernameField = UITextField()
        usernameField!.frame = CGRectMake(screenSize.width/2 - 100, screenSize.height * 0.3, 200, screenSize.height * 0.045)
        usernameField!.placeholder = "Username"
        usernameField!.backgroundColor = UIColor.init(red: 0.92, green: 0.92, blue: 0.95, alpha: 0.7)
        usernameField!.autocapitalizationType = UITextAutocapitalizationType.None
        view.addSubview(usernameField!)
        
        passwordField = UITextField()
        passwordField!.frame = CGRectMake(screenSize.width/2 - 100, screenSize.height * 0.37, 200, screenSize.height * 0.045)
        passwordField!.placeholder = "Password"
        passwordField!.secureTextEntry = true
        passwordField!.backgroundColor = UIColor.init(red: 0.92, green: 0.92, blue: 0.95, alpha: 0.7)
        passwordField!.autocapitalizationType = UITextAutocapitalizationType.None
        view.addSubview(passwordField!)
    }
    
    func initializeRegisterButton() {
        let cameraButton: UIButton = UIButton()
        cameraButton.frame = CGRectMake(screenSize.height * 0.35, screenSize.height * 0.45, screenSize.height * 0.06, screenSize.height * 0.06)
        let cameraIcon: UIImage = UIImage(named: "camera_icon")!
        cameraButton.setImage(cameraIcon , forState: UIControlState.Normal)
        cameraButton.addTarget(self, action: "loadImageButtonTapped:", forControlEvents: UIControlEvents.TouchUpInside)
        cameraButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        cameraButton.setTitleColor(UIColor.cyanColor(), forState: UIControlState.Highlighted)
//        view.addSubview(cameraButton)
        
        
        let button: UIButton = UIButton()
        button.frame = CGRectMake(screenSize.width/2 - 114, screenSize.height * 0.7, 100, screenSize.height * 0.045)
//        button.backgroundColor = UIColor.cyanColor()
        button.setTitle("Register!", forState: UIControlState.Normal)
        button.addTarget(self, action: "register:", forControlEvents: UIControlEvents.TouchUpInside)
        button.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        view.addSubview(button)
        
        
        let loginButton: UIButton = UIButton()
        loginButton.frame = CGRectMake(screenSize.width/2 + 12, screenSize.height * 0.7, 100, screenSize.height * 0.045)
//        loginButton.backgroundColor = UIColor.cyanColor()
        loginButton.setTitle("Log in!", forState: UIControlState.Normal)
        loginButton.addTarget(self, action: "login:", forControlEvents: UIControlEvents.TouchUpInside)
        loginButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        loginButton.alpha = 0.9
        view.addSubview(loginButton)
        

    }
    
    func loadImageButtonTapped(sender: UIButton) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .PhotoLibrary
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
//            let compressedData = UIImageJPEGRepresentation(pickedImage, 0.0)
//            let compressedImage = UIImage(data: compressedData!)
            
            
            defaultPic = UIImageView(image: pickedImage)
            defaultPic.frame = CGRect(x: screenSize.width * 0.5 - screenSize.height * 0.06, y: screenSize.height * 0.44, width: screenSize.height * 0.12, height: screenSize.height * 0.12)
            defaultPic.layer.cornerRadius = defaultPic.frame.size.height / 2
            defaultPic.layer.masksToBounds = true
            defaultPic.layer.borderWidth = 0;
            self.view.addSubview(defaultPic)
            //        user_icon = UIImageView(image: decodeStringToImage(encodeImageToString(image)))
            

            self.view.addSubview(defaultPic)
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    func signupErrorAlert(title: String, message: String) {
        // Called upon signup error to let the user know signup didn't work.
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }
    
    
    //for register, check to see if there's an existing user
    
    func register(sender: UIButton) {
        sender.setTitleColor(UIColor.cyanColor(), forState: .Normal)
        if (usernameField!.text! == "" || passwordField!.text! == "") {
            self.signupErrorAlert("login error", message: "empty username or password, try again")
            sender.setTitleColor(UIColor.blackColor(), forState: .Normal)
        } else {
        clientRef.observeEventType(.Value, withBlock: {
            snapshot in
            if let somethingelse = snapshot.value[self.usernameField!.text!] {
                if let something = snapshot.value[self.usernameField!.text!]! {
                    self.signupErrorAlert("login error", message: "existing username, try again")
                    sender.setTitleColor(UIColor.blackColor(), forState: .Normal)
                } else {
                    self.successfulRegistration()
                }
            } else {
                self.successfulRegistration()
            }
            
        })
        }
    }
    

    func successfulRegistration() {
        let historyList: [String] = ["nil"]
        
//        let photoString: String = encodeImageToString(UIImage(named: "profile")!)
        
//        let photoString: String = encodeImageToString(defaultPic.image!)
        let photoData = UIImageJPEGRepresentation(defaultPic.image!, 0.1)
        
        let photoString:String = (photoData?.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.Encoding64CharacterLineLength))!

        let newClientRef = clientRef.childByAppendingPath(usernameField!.text)
        
//        startDate = NSDate()
        
        newClientRef.setValue(["password": self.passwordField!.text!, "history": historyList, "default_photo": photoString, "start": self.startDate!, "flakes": 0])

        
  
    
        let vc:DashBoardViewController = (UIStoryboard(name: "Main", bundle: nil)).instantiateViewControllerWithIdentifier("Dashboard") as!DashBoardViewController
    
        let currentClient = Client(username: usernameField!.text!, password: passwordField!.text!, history: historyList, photo: photoString, start: self.startDate!, flakes: 0)
        
        vc.username = usernameField!.text!
    
        let menuTable = MenuTableViewController()
        menuTable.dashboardVC = vc;
        menuTable.currClient = currentClient
    
        let drawerCon = DrawerController(centerViewController: UINavigationController(rootViewController: vc),leftDrawerViewController: menuTable)
    
        drawerCon.openDrawerGestureModeMask = OpenDrawerGestureMode.BezelPanningCenterView
        drawerCon.closeDrawerGestureModeMask = CloseDrawerGestureMode.PanningCenterView
    
        self.presentViewController(drawerCon, animated: true, completion: nil)
    }
    

    //check to see if there exists a user, and to see if the password is the same
    func login(sender: AnyObject) {
        sender.setTitleColor(UIColor.cyanColor(), forState: .Normal)
        clientRef.observeEventType(.Value, withBlock: {
            snapshot in
            if let password1 = snapshot.value[self.usernameField!.text!] {
                if let password = snapshot.value[self.usernameField!.text!]! {
                    let passcode = password["password"] as! String
                    if (passcode == self.passwordField!.text!) {
                        let imageStr = password["default_photo"] as! String
                        let usernameStr = self.usernameField!.text!
                        let historyDat = password["history"] as! [String]
                        let startDat = password["start"] as! String
                        let flakesDat = password["flakes"] as! Int
                        
                        self.successfulLogin(usernameStr, pass: passcode, img: imageStr, hist: historyDat, start: startDat, flakes: flakesDat)
                    } else {
                        self.signupErrorAlert("login error", message: "incorrect password, try again")
                        sender.setTitleColor(UIColor.blackColor(), forState: .Normal)
                    }
                } else {
                    self.signupErrorAlert("login error", message: "username doesn't exist, try again")
                    sender.setTitleColor(UIColor.blackColor(), forState: .Normal)
                }
            } else {
                self.signupErrorAlert("login error", message: "no current registered users, please go back and register")
                sender.setTitleColor(UIColor.blackColor(), forState: .Normal)
            }
            
        })

    }

    func successfulLogin(username: String, pass: String, img: String, hist: [String], start: String, flakes: Int) {
        
        let currentClient = Client(username: username, password: pass, history: hist, photo: img, start: start, flakes: flakes)
        
        let vc:DashBoardViewController = (UIStoryboard(name: "Main", bundle: nil)).instantiateViewControllerWithIdentifier("Dashboard") as!DashBoardViewController
        
        vc.username = usernameField!.text!
        

//        print(currentClient.username)
        
        let menuTable = MenuTableViewController()
        menuTable.dashboardVC = vc;
        menuTable.currClient = currentClient
        
        
        
        let drawerCon = DrawerController(centerViewController: UINavigationController(rootViewController: vc),leftDrawerViewController: menuTable)
        
        drawerCon.openDrawerGestureModeMask = OpenDrawerGestureMode.BezelPanningCenterView
        drawerCon.closeDrawerGestureModeMask = CloseDrawerGestureMode.PanningCenterView
        

        
        self.presentViewController(drawerCon, animated: true, completion: nil)
    }

}

