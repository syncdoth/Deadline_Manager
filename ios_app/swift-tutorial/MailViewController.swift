//
//  MailViewController.swift
//  swift-tutorial
//
//  Created by Jason Johnston on 4/3/17.
//  Copyright © 2017 Microsoft. All rights reserved.
//  Licensed under the MIT license. See LICENSE.txt in the project root for license information.
//

import UIKit

class MailViewController: UIViewController {
    
    @IBOutlet var loginButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var AccountName: UILabel!
    @IBOutlet weak var Busy_ness: UILabel!
    
    
    
    var dataSource: MessagesDataSource?
    
    let service = OutlookService.shared()
    
    
    
    
    func setLogInState(loggedIn: Bool) {
        if (loggedIn) {
            loginButton.setTitle("Log Out", for: UIControlState.normal)
        }
        else {
            loginButton.setTitle("Log In", for: UIControlState.normal)
        }
    }
    
    @IBAction func loginButtonTapped(sender: AnyObject) {
        if (service.isLoggedIn) {
            // Logout
            service.logout()
            setLogInState(loggedIn: false)
        } else {
            // Login
            service.login(from: self) {
                error in
                if let unwrappedError = error {
                    NSLog("Error logging in: \(unwrappedError)")
                } else {
                    NSLog("Successfully logged in.")
                    self.setLogInState(loggedIn: true)
                    self.loadUserData()
                }
            }
        }
    }
    
    func loadUserData() {
        service.getUserEmail() {
            email in
            if let unwrappedEmail = email {
                NSLog("Hello \(unwrappedEmail)")
                
                self.service.getInboxMessages() {
                    messages in
                    if let unwrappedMessages = messages {
                        for (message) in unwrappedMessages["value"].arrayValue{
                            NSLog(message["body"]["content"].stringValue)
                        }
                        self.dataSource = MessagesDataSource(messages: unwrappedMessages["value"].arrayValue)
                        self.tableView.dataSource = self.dataSource
                        self.tableView.reloadData()
                        
                        
                        self.AccountName.text = self.dataSource?.myAccount.name
                        let busy_score : Int = self.dataSource!.myAccount.busy_ness
                        
                        
                        if busy_score > 30{
                            self.Busy_ness.text = "Very busy"
                        }
                        else if busy_score > 20{
                            self.Busy_ness.text = "Busy"
                        }
                        else if busy_score > 10{
                            self.Busy_ness.text = "Little busy"
                        }
                        else{
                            self.Busy_ness.text = "Not busy"
                        }
                        
                    }
                }
            }
        }
    
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.estimatedRowHeight = 90;
        tableView.rowHeight = UITableViewAutomaticDimension
        
        setLogInState(loggedIn: service.isLoggedIn)
        if (service.isLoggedIn) {
            loadUserData()
        }
        
    }
    
    @IBAction func OnRefresh(_ sender: Any) {
        if (service.isLoggedIn) {
            loadUserData()
        }
    }
    @IBAction func OnColleagues(_ sender: Any) {
        performSegue(withIdentifier: "showColleagues", sender: self)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
struct Hi {
    
    
    var busy_ness : Int
    var name : String
    
    
    init(_busy_ness : Int = 0, _name : String = "Apple"){
        self.busy_ness = _busy_ness
        self.name = _name
    }
}



class ColleagueViewController: UIViewController {

    @IBOutlet var label1: UILabel!
    

    @IBOutlet var label2: UILabel!
    @IBOutlet var label3: UILabel!
    @IBOutlet var label4: UILabel!
    @IBOutlet var label5: UILabel!
    
    @IBOutlet var label6: UILabel!
    @IBOutlet var label7: UILabel!
    @IBOutlet var label8: UILabel!
    @IBOutlet var label9: UILabel!
    
    
    
    
    let col_dataSource = AccountDataSource(happy: "Hi")
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        col_tableView.dataSource = col_dataSource
//        self.col_tableView.reloadData()
//        col_tableView.estimatedRowHeight = 90;
//        col_tableView.rowHeight = UITableViewAutomaticDimension
        
        let Ben = Account(_busy_ness: 1, _name: "Ben")
        let John = Account(_busy_ness: 5, _name: "John")
        let Mark = Account(_busy_ness: 4, _name: "Mark")
        let Kim = Account(_busy_ness: 3, _name: "Kim")
        let Lee = Account(_busy_ness: 2, _name: "Lee")
        let Jason = Account(_busy_ness: 5, _name: "Jason")
        let Sam = Account(_busy_ness: 3, _name: "Sam")
        let Vicky = Account(_busy_ness: 3, _name: "Vicky")
        let Mike = Account(_busy_ness: 2, _name: "Mike")
        
        var cl = [Account]()
        cl.append(Ben)
        cl.append(John)
        cl.append(Mark)
        cl.append(Kim)
        cl.append(Lee)
        cl.append(Jason)
        cl.append(Sam)
        cl.append(Vicky)
        cl.append(Mike)
    
        var busy: String
        var arr  =  [String]()
        for colleague in cl{
            if colleague.busy_ness == 5{
                busy = "Very busy"
            }
            else if colleague.busy_ness == 4{
                busy = "Busy"
            }
            else if colleague.busy_ness == 3{
                busy = "Little busy"
            }
            else if colleague.busy_ness == 2{
                busy = "Not busy"
            }
            else {
                busy = "On leave"
            }
            arr.append(colleague.name + ":   " + busy)
        }
        
        label1.text = arr[0]
        label2.text = arr[1]
        label3.text = arr[2]
        label4.text = arr[3]
        label5.text = arr[4]
        label6.text = arr[5]
        label7.text = arr[6]
        label8.text = arr[7]
        label9.text = arr[8]
        
        
    }
    
    @IBAction func OnBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
