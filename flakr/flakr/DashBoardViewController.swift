////
////  DashBoardViewController.swift
////  flakr
////
////  Created by Jason Ma on 4/24/16.
////  Copyright © 2016 tiffmomdotcom. All rights reserved.
////
//

import UIKit

class DashBoardViewController: UITableViewController {
    
    var label: UILabel?
    var username: String?
    var dashboard_table: UITableView?
    var data: [String] = ["hello", "world", "a","b","c","d","e","f","g","hello", "world", "a","b","c","d","e","f","g"]
    let cellReuseIdendifier = "cell"
    
    let screenSize: CGRect = UIScreen.mainScreen().bounds
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        initializeSplashLabels()
        self.title = "Welcome, " + username!
        var b = UIBarButtonItem(barButtonSystemItem: .Organize, target: self, action: Selector("sayHello"))
        self.navigationItem.rightBarButtonItem = b
//        self.navigationController!.title = "plswork"
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        tableView.registerClass(MyCustomCell.self, forCellReuseIdentifier: cellReuseIdendifier)
        
//        tableView.dataSource = self
//        tableView.delegate = self

        //
    }
    func sayHello() {
        print("hello")
    }
    
    func initializeSplashLabels() {
        label = UILabel()
        label!.frame = CGRectMake(screenSize.width/2 - 150, 0.1 * screenSize.height/10, 300, 200)
        label!.numberOfLines = -1
        label!.text = "Welcome, " + username!
        label!.font = UIFont(name: label!.font.fontName, size: 30)
        view.addSubview(label!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        //
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellReuseIdendifier, forIndexPath: indexPath) as! MyCustomCell
        cell.myLabel.text = data[indexPath.row]
        cell.cellWidth = screenSize.width
        cell.cellHeight = screenSize.height / 7
        cell.addButtons()
        return cell
    }
    
    func getCell(data: String, width: CGFloat, height: CGFloat)->UITableViewCell {
        print("this is running")
        let cell: UITableViewCell = UITableViewCell(style: .Subtitle, reuseIdentifier: "protoCell")
        cell.textLabel?.text = data
        cell.textLabel?.font = UIFont(name:"Futura",size: 15.00)
//        let myLabel = UILabel()
//        myLabel.frame = CGRectMake(0, 0, width, height / 2)
//        myLabel.backgroundColor = UIColor.yellowColor()
//        cell.addSubview(myLabel)
        let likeButton = UIButton()
        likeButton.backgroundColor = UIColor.blueColor()
        likeButton.frame = CGRectMake(width / 2, height / 2, width / 8, height / 2)
        likeButton.setTitle("Like", forState: UIControlState.Normal)
        likeButton.addTarget(self, action: "testing:", forControlEvents: UIControlEvents.TouchUpInside)
        
        cell.addSubview((likeButton))
        return cell
    }
    
    func buttonClicked() {
        print("hello")
        //        print(myLabel.text!)
    }
    
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return screenSize.height / 7
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //callback whenever I click on a cell
//         carTableView?.deselectRowAtIndexPath(indexPath, animated: true)
        print(data[indexPath.row])
    }
    
}

