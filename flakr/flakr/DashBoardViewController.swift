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


    
    var flakeData: [FlakeData] = [FlakeData(flaker: "Wilson", flakee: "Jason", timeStamp: 5, reason: "Amie wouldn't let me"), FlakeData(flaker: "Ajay", flakee: "Jason", timeStamp: 5, reason: "No money"), FlakeData(flaker: "Wilson", flakee: "Jason", timeStamp: 5, reason: "Because I always flake")]

    
    let screenSize: CGRect = UIScreen.mainScreen().bounds
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        initializeSplashLabels()
        self.title = "Dashboard"
        var b = UIBarButtonItem(barButtonSystemItem: .Refresh, target: self, action: Selector("sayHello"))
        self.navigationItem.rightBarButtonItem = b

        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        tableView.registerClass(MyCustomCell.self, forCellReuseIdentifier: cellReuseIdendifier)
        
        tableView.dataSource = self
        tableView.delegate = self

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
        return flakeData.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellReuseIdendifier, forIndexPath: indexPath) as! MyCustomCell
        cell.currFlake = flakeData[indexPath.row]
        cell.cellWidth = screenSize.width
        cell.cellHeight = screenSize.height / 7
        cell.addButtons()
        cell.addLabels()
        cell.addImages()
        return cell
    }
    
    func buttonClicked() {
        print("hello")
    }
    
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return screenSize.height / 7
    }
    
    
//    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//    }
    
}

