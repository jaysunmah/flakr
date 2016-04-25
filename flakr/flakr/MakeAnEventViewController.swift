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
//        view.addSubview(myPicker)
    }
    
    func addLabels() {
        
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
        view.addSubview(flakeReasonField!)
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
