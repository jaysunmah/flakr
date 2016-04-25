//
//  DashBoardViewController.swift
//  flakr
//
//  Created by Jason Ma on 4/24/16.
//  Copyright © 2016 tiffmomdotcom. All rights reserved.
//

import UIKit

//class MakeAnEventViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {
class MakeAnEventViewController: UIViewController {

    var eventTitle: UILabel?
    var flakerLabel: UILabel?
    var flakeeLabel: UILabel?
    var reasonLabel: UILabel?
    
    
    var flakerField: UITextField?
    var flakeeField: UITextField?
    var flakeReasonField: UITextField?
    
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
        
        flakeeLabel = UILabel()
        flakeeLabel!.frame = CGRectMake(screenSize.height * 0.08, screenSize.height * 0.28, 200, screenSize.height * 0.045)
        flakeeLabel!.text = "Flakee"
        flakeeLabel!.font = UIFont(name: flakeeLabel!.font.fontName, size: 20)
        view.addSubview(flakeeLabel!)

        reasonLabel = UILabel()
        reasonLabel!.frame = CGRectMake(screenSize.height * 0.08, screenSize.height * 0.36, 200, screenSize.height * 0.045)
        reasonLabel!.text = "Reason"
        reasonLabel!.font = UIFont(name: reasonLabel!.font.fontName, size: 20)
        view.addSubview(reasonLabel!)
        
    }
    
    
    func addTextFields() {
        flakerField = UITextField()
        flakerField!.frame = CGRectMake(screenSize.height * 0.2, screenSize.height * 0.2, 200, screenSize.height * 0.045)
        flakerField!.placeholder = "Flaker"
        flakerField!.backgroundColor = UIColor.cyanColor()
        view.addSubview(flakerField!)
        
        flakeeField = UITextField()
        flakeeField!.frame = CGRectMake(screenSize.height * 0.2, screenSize.height * 0.28, 200, screenSize.height * 0.045)
        flakeeField!.placeholder = "Flakee"
        flakeeField!.backgroundColor = UIColor.cyanColor()
        view.addSubview(flakeeField!)
        
        flakeReasonField = UITextField()
        flakeReasonField!.frame = CGRectMake(screenSize.height * 0.2, screenSize.height * 0.36, 200, screenSize.height * 0.045)
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
        
        let flakeReason = flakeReasonField!.text
        
        if flakeReason != "" {
            
            // Build the new Joke.
            // AnyObject is needed because of the votes of type Int.
            
            let newFlake: Dictionary<String, AnyObject> = [
                "flaker": flakerField!.text!,
                "flakee": flakeeField!.text!,
                "reason": flakeReasonField!.text!
            ]
            
            // Send it over to DataService to seal the deal.
            
            DataService.dataService.createNewFlake(newFlake)
            
            if let navController = self.navigationController {
                navController.popViewControllerAnimated(true)
            }
            print("added")
            flakeReasonField!.text = ""
            flakeeField!.text = ""
            flakerField!.text = ""
        }
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
