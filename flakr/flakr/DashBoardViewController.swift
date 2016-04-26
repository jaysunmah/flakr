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

class DashBoardViewController: UITableViewController {
    
    var label: UILabel?
    var username: String?
    var currClient: Client?
    var dashboard_table: UITableView?
    var data: [String] = ["hello", "world", "a","b","c","d","e","f","g","hello", "world", "a","b","c","d","e","f","g"]
    let cellReuseIdendifier = "cell"    


    
    var flakeData = [Flake]()

    
    let screenSize: CGRect = UIScreen.mainScreen().bounds
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        initializeSplashLabels()
        self.title = "Dashboard"
        var b = UIBarButtonItem(barButtonSystemItem: .Refresh, target: self, action: Selector("reloadTables"))
        self.navigationItem.rightBarButtonItem = b
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        tableView.registerClass(MyCustomCell.self, forCellReuseIdentifier: cellReuseIdendifier)
        tableView.dataSource = self
        tableView.delegate = self

        DataService.dataService.FLAKE_REF.observeEventType(.Value, withBlock: { snapshot in
            
            // The snapshot is a current look at our jokes data.
            
            print(snapshot.value)
            
            self.flakeData = []
            
            if let snapshots = snapshot.children.allObjects as? [FDataSnapshot] {
                
                for snap in snapshots {
                    
                    if let postDictionary = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key
                        let flake = Flake(key: key, dictionary: postDictionary)
                        
                        // Items are returned chronologically, but it's more fun with the newest jokes first.
                        
                        self.flakeData.insert(flake, atIndex: 0)
                    }
                }
                
            }
            
            // Be sure that the tableView updates when there is new data.
            
            self.tableView.reloadData()
        })
    }
    
    func reloadTables() {
        self.tableView.reloadData()
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

