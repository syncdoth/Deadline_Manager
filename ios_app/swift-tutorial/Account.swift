//
//  Colleagues.swift
//  swift-tutorial
//
//  Created by Sam Choi on 14/4/2019.
//  Copyright © 2019 Microsoft. All rights reserved.
//

import Foundation
import UIKit

struct Account {
    
    
    var busy_ness : Int
    var name : String

    
    init(_busy_ness : Int = 0, _name : String = "Apple"){
        self.busy_ness = _busy_ness
        self.name = _name
    }
}

class AccountCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var busynessLabel: UILabel!
    
    var name: String? {
        didSet {
            nameLabel.text = name
        }
    }
    
    var busy_ness: String? {
        didSet {
            busynessLabel.text = busy_ness
        }
    }
    
}

class AccountDataSource: NSObject, UITableViewDataSource {
    
    let Ben = Account(_busy_ness: 1, _name: "Ben")
    let John = Account(_busy_ness: 5, _name: "John")
    let Mark = Account(_busy_ness: 4, _name: "Mark")
    let Kim = Account(_busy_ness: 3, _name: "Kim")
    let Lee = Account(_busy_ness: 2, _name: "Lee")
    let Jason = Account(_busy_ness: 5, _name: "Jason")
    let Sam = Account(_busy_ness: 3, _name: "Sam")
    let Vicky = Account(_busy_ness: 3, _name: "Vicky")
    let Mike = Account(_busy_ness: 2, _name: "Mike")

    let colleagues : [Account]
    
    init(happy: String){
        
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
        colleagues = cl
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("1")
        return colleagues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        print("2")
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: AccountCell.self)) as! AccountCell
        let colleague = colleagues[indexPath.row]
        
        cell.name = colleague.name
        
        if colleague.busy_ness == 5{
            cell.busy_ness = "Very busy"
        }
        else if colleague.busy_ness == 4{
            cell.busy_ness = "Busy"
        }
        else if colleague.busy_ness == 3{
            cell.busy_ness = "Little busy"
        }
        else if colleague.busy_ness == 2{
            cell.busy_ness = "Not busy"
        }
        else {
            cell.busy_ness = "On leave"
        }
        
        
        print("y")
        return cell
    }
}
