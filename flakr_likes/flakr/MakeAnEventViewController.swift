//
//  DashBoardViewController.swift
//  flakr
//
//  Created by Jason Ma on 4/24/16.
//  Copyright © 2016 tiffmomdotcom. All rights reserved.
//

import UIKit
import Firebase

//class MakeAnEventViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {
class MakeAnEventViewController: UIViewController {

    var clientRef = Firebase(url:"https://incandescent-heat-1881.firebaseio.com/users")
    
    var eventTitle: UILabel?
    var flakerLabel: UILabel?
    var flakeeLabel: UILabel?
    var reasonLabel: UILabel?
    
    
    var flakerField: UITextField?
    var flakeeField: UITextField?
    var flakeReasonField: UITextField?
    var currClient: Client?
    
//    let pickerData = ["flaked on", "ditched", "abandoned", "left", "wussed out"]
    let screenSize: CGRect = UIScreen.mainScreen().bounds
    
//    enum PickerComponent:Int{
//        case size = 0
//        case topping = 1
//    }
    
    var myLabel: UILabel = UILabel()
//    var myPicker: UIPickerView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Rate an event"
        self.view.backgroundColor = UIColor.whiteColor()
        print("ITS LIST")
        print(currClient!.username)
        
//        myPicker.delegate = self
//        myPicker.dataSource = self
//        myPicker.frame = CGRect(x: screenSize.width * 0.1, y: screenSize.height * 0.1, width: screenSize.width * 0.8, height: screenSize.height * 0.4)
        
        addTextFields()
        addLabels()
        addButtons()
//        view.addSubview(myPicker)
    }
    
    func addLabels() {
        eventTitle = UILabel()
        eventTitle!.frame = CGRectMake(screenSize.width/2 - 100, screenSize.height * 0.1 , 200, screenSize.height/10)
        eventTitle!.text = "Rate a person"
        eventTitle!.font = UIFont(name: eventTitle!.font.fontName, size: 30)
        view.addSubview(eventTitle!)
        
        flakerLabel = UILabel()
        flakerLabel!.frame = CGRectMake(screenSize.height * 0.08, screenSize.height * 0.2, 200, screenSize.height * 0.045)
        flakerLabel!.text = "Flaker"
        flakerLabel!.font = UIFont(name: flakerLabel!.font.fontName, size: 20)
        view.addSubview(flakerLabel!)
        
//        flakeeLabel = UILabel()
//        flakeeLabel!.frame = CGRectMake(screenSize.height * 0.08, screenSize.height * 0.28, 200, screenSize.height * 0.045)
//        flakeeLabel!.text = "Flakee"
//        flakeeLabel!.font = UIFont(name: flakeeLabel!.font.fontName, size: 20)
//        view.addSubview(flakeeLabel!)

        reasonLabel = UILabel()
        reasonLabel!.frame = CGRectMake(screenSize.height * 0.08, screenSize.height * 0.30, 200, screenSize.height * 0.045)
        reasonLabel!.text = "Reason"
        reasonLabel!.font = UIFont(name: reasonLabel!.font.fontName, size: 20)
        view.addSubview(reasonLabel!)
        
    }
    
    
    func addTextFields() {
        flakerField = UITextField()
        flakerField!.frame = CGRectMake(screenSize.height * 0.2, screenSize.height * 0.2, 200, screenSize.height * 0.045)
        flakerField!.placeholder = "Flaker"
        flakerField!.backgroundColor = UIColor.cyanColor()
        flakerField!.autocapitalizationType = UITextAutocapitalizationType.None
        view.addSubview(flakerField!)
        
        flakeeField = UITextField()
        flakeeField!.frame = CGRectMake(screenSize.height * 0.2, screenSize.height * 0.28, 200, screenSize.height * 0.045)
        flakeeField!.placeholder = "Flakee"
        flakeeField!.backgroundColor = UIColor.cyanColor()
        flakeeField!.autocapitalizationType = UITextAutocapitalizationType.None
        flakeeField!.text = currClient!.username
//        view.addSubview(flakeeField!)
        
        flakeReasonField = UITextField()
        flakeReasonField!.frame = CGRectMake(screenSize.height * 0.2, screenSize.height * 0.30, 200, screenSize.height * 0.045)
        flakeReasonField!.placeholder = "Reason"
        flakeReasonField!.backgroundColor = UIColor.cyanColor()
        flakeReasonField!.autocapitalizationType = UITextAutocapitalizationType.None
        view.addSubview(flakeReasonField!)
    }

    func addButtons() {
        let button: UIButton = UIButton()
        button.frame = CGRectMake(screenSize.height * 0.21, screenSize.height * 0.44, 100, screenSize.height * 0.045)
        button.setTitle("Add event!", forState: UIControlState.Normal)
        button.addTarget(self, action: "saveFlake:", forControlEvents: UIControlEvents.TouchUpInside)
        button.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        view.addSubview(button)
    }
    
    func saveFlake(sender: AnyObject) {
        
        
        clientRef.observeEventType(.Value, withBlock: {
            snapshot in
            if let somethingelse = snapshot.value[self.flakerField!.text!] {
                if let something = snapshot.value[self.flakerField!.text!]! {
                    if self.flakeReasonField!.text != "" {
                        var currClientRef = Firebase(url:"https://incandescent-heat-1881.firebaseio.com/users/" + self.flakerField!.text!)
                        // Build the new Joke.
                        // AnyObject is needed because of the votes of type Int.
//                        clientRef.setValue(something!["flakes"] + 1)
                        
                        let newFlake: Dictionary<String, AnyObject> = [
                            "flaker": self.flakerField!.text!,
                            "flakee": self.flakeeField!.text!,
                            "reason": self.flakeReasonField!.text!,
                            "likes": ["~NULL~", "~NULL~"]
                        ]
                        
                        let newFlakesCount = something["flakes"] as! Int + 1

                        
                        print("updating...")
                        currClientRef.setValue(["password": snapshot.value[self.flakerField!.text!]!!["password"]!!, "history": snapshot.value[self.flakerField!.text!]!!["history"]!!, "start": snapshot.value[self.flakerField!.text!]!!["start"]!!, "flakes": newFlakesCount, "default_photo": snapshot.value[self.flakerField!.text!]!!["default_photo"]!!])
                        
//                        updateFlakeCount(count: newFlakesCount)
                        
                        // Send it over to DataService to seal the deal.
                        
                        DataService.dataService.createNewFlake(newFlake)
                        
                        if let navController = self.navigationController {
                            navController.popViewControllerAnimated(true)
                        }

                        self.flakeReasonField!.text = ""
//                        self.flakeeField!.text = ""
                        self.flakerField!.text = ""
                    }
                } else {
                    
                    print("this is being called again")
                    print(self.flakeReasonField!.text)
                    
                    if self.flakeReasonField!.text != "" {
                        self.signupErrorAlert("login error", message: "nonexistant user, user will show up with a default photo")
                        // Build the new Joke.
                        // AnyObject is needed because of the votes of type Int.
                        
                        let newFlake: Dictionary<String, AnyObject> = [
                            "flaker": self.flakerField!.text!,
                            "flakee": self.flakeeField!.text!,
                            "reason": self.flakeReasonField!.text!,
                            "likes": ["~NULL~", "~NULL~"]
                        ]
                        
                        // Send it over to DataService to seal the deal.
                        
                        DataService.dataService.createNewFlake(newFlake)
                        
                        if let navController = self.navigationController {
                            navController.popViewControllerAnimated(true)
                        }
                        
                        self.flakeReasonField!.text = ""
                        //                        self.flakeeField!.text = ""
                        self.flakerField!.text = ""
                    }
                }
            } else {
                self.signupErrorAlert("login error", message: "nonexistant user, try again")            }
            
        })
        
        let flakeReason = flakeReasonField!.text
        

    }
//    func updateFlakeCount(count: int) {
//        
//        currClientRef.updateChildValues(<#T##values: [NSObject : AnyObject]!##[NSObject : AnyObject]!#>)(["flakes": newFlakesCount])
//    }
    
    func signupErrorAlert(title: String, message: String) {
        // Called upon signup error to let the user know signup didn't work.
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }
    
    func register(sender: AnyObject) {
        clientRef.observeEventType(.Value, withBlock: {
            snapshot in
            if let somethingelse = snapshot.value[self.flakerField!.text!] {
                if let something = snapshot.value[self.flakerField!.text!]! {
                    //do something here, it's valid
                } else {
                    self.signupErrorAlert("login error", message: "nonexistant user, try again")
                }
            } else {
                self.signupErrorAlert("login error", message: "nonexistant user, try again")            }
            
        })
    }
    
    
//    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        print(pickerData[row])
//    }
//    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
//        return 1    }
//    
//    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return pickerData.count
//    }
//    
//    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return pickerData[row]
//    }
}
