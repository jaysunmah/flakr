////
////  DashBoardViewController.swift
////  flakr
////
////  Created by Jason Ma on 4/24/16.
////  Copyright © 2016 tiffmomdotcom. All rights reserved.
////
//

import UIKit
import DrawerController
class MenuTableViewController: UITableViewController {
    
    
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Portrait
    }
    
    
    var dashboard_table: UITableView?
    var data: [String] = ["dashboard", "profile", "rate an event", "log out"]
    let cellReuseIdendifier = "cell"
    
    var currClient: Client?
    var dashboardVC: DashBoardViewController?
    var profileVC: ProfileViewController?
    
    let screenSize: CGRect = UIScreen.mainScreen().bounds
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        tableView.registerClass(MyCustomCell.self, forCellReuseIdentifier: cellReuseIdendifier)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        //
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        //
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel!.text = data[indexPath.row]
        return cell
    }
    
    func buttonClicked() {
        print("hello")
    }
    
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return screenSize.height / 10
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        print(data[indexPath.row])
        navigateViews(data[indexPath.row])

    }
    
    func navigateViews(selectedView: String) {
        //call new navigations
        print(selectedView)
        print(currClient!.username)
        let tempMakeEventVC = MakeAnEventViewController()
        tempMakeEventVC.currClient = currClient
        
        let profileVC = ProfileViewController()
        profileVC.currFlake = currClient
        
        
        if (selectedView == "dashboard") {
        evo_drawerController?.setCenterViewController(UINavigationController(rootViewController: DashBoardViewController()), withCloseAnimation: true, completion: nil)
        } else  if (selectedView == "profile"){
        evo_drawerController?.setCenterViewController(UINavigationController(rootViewController: profileVC), withCloseAnimation: true, completion: nil)
        } else if (selectedView == "rate an event") {
        evo_drawerController?.setCenterViewController(UINavigationController(rootViewController: tempMakeEventVC), withCloseAnimation: true, completion: nil)
        } else if (selectedView == "log out") {
            evo_drawerController?.setCenterViewController(UINavigationController(rootViewController: ViewController()), withCloseAnimation: true, completion: nil)
        }

        
    }
    
}

