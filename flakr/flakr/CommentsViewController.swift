////
////  DashBoardViewController.swift
////  flakr
////
////  Created by Jason Ma on 4/24/16.
////  Copyright © 2016 tiffmomdotcom. All rights reserved.
////
//

import UIKit
import Firebase

class CommentsViewController: UIViewController {
    
    var clientRef = Firebase(url:"https://incandescent-heat-1881.firebaseio.com/users")
    
    var user_icon: UIImageView = UIImageView()
    var label: UILabel?
    var dateLabel: UILabel?
    var flakesLabel: UILabel?
    
    let screenSize: CGRect = UIScreen.mainScreen().bounds
    var currFlake: Client?
    
    var numFlakes: Int = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Profile"
        self.view.backgroundColor = UIColor.whiteColor()
        addImages()
        
        clientRef.observeEventType(.Value, withBlock: {
            snapshot in
            self.numFlakes = snapshot.value[self.currFlake!.username]!!["flakes"]! as! Int
            self.addLabels()
        })
        
        //        print("FLAKES")
        //        print(self.numFlakes)
        
        
        //        addLabels()
        
        
        
    }
    
    func addLabels() {
        label = UILabel()
        label!.frame = CGRect(x: screenSize.width/2 - 100, y: screenSize.height * 0.35, width: 200, height: 50)
        label!.text = currFlake!.username
        label!.textAlignment = NSTextAlignment.Center
        label!.font = UIFont(name: label!.font.fontName, size: 50)
        view.addSubview(label!)
        
        
        dateLabel = UILabel()
        dateLabel!.frame = CGRect(x: screenSize.width * 0.11, y: screenSize.height * 0.44, width: screenSize.width * 0.7, height: 50)
        dateLabel!.text = "Date joined: " + currFlake!.start
        dateLabel!.font = UIFont(name: label!.font.fontName, size: 20)
        view.addSubview(dateLabel!)
        
        
        
        flakesLabel = UILabel()
        flakesLabel!.frame = CGRect(x: screenSize.width * 0.11, y: screenSize.height * 0.49, width: screenSize.width * 0.7, height: 50)
        flakesLabel!.text = "Flakes: " + String(numFlakes)
        flakesLabel!.font = UIFont(name: label!.font.fontName, size: 20)
        view.addSubview(flakesLabel!)
    }
    
    func addImages() {
        clientRef.observeEventType(.Value, withBlock: {
            snapshot in
            if let password1 = snapshot.value[self.currFlake!.username] {
                if let person = snapshot.value[self.currFlake!.username]! {
                    var photostr = person["default_photo"] as! String
                    self.addImages_helper(true, photo: photostr)
                } else {
                    self.addImages_helper(false, photo: "")
                }
            } else {
                self.addImages_helper(false, photo: "")
            }
        })
    }
    
    func addImages_helper(flag:Bool, photo: String) {
        var image = UIImage()
        if (flag) {
            image = decodeStringToImage(photo)
        } else {
            image = UIImage(named: "profile")!
        }
        
        
        user_icon = UIImageView(image: image)
        //        user_icon = UIImageView(image: decodeStringToImage(encodeImageToString(image)))
        
        //        user_icon.contentMode = UIViewContentMode.ScaleAspectFit
        user_icon.frame = CGRect(x: screenSize.width / 2 - 75, y: 90, width: 150, height: 150)
        user_icon.layer.cornerRadius = user_icon.frame.size.height / 2
        user_icon.layer.masksToBounds = true
        user_icon.layer.borderWidth = 0;
        self.view.addSubview(user_icon)
    }
    
    func decodeStringToImage(something: String)->UIImage {
        let decodedData = NSData(base64EncodedString: something, options: NSDataBase64DecodingOptions.IgnoreUnknownCharacters)
        let newImage: UIImage = UIImage(data: decodedData!)!
        return newImage
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

