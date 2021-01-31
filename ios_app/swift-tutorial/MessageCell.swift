//
//  MessageCell.swift
//  swift-tutorial
//
//  Created by Jason Johnston on 4/4/17.
//  Copyright © 2017 Microsoft. All rights reserved.
//  Licensed under the MIT license. See LICENSE.txt in the project root for license information.
//

import Foundation
import UIKit
import SwiftyJSON
import MKDataDetector
import CoreML

struct Message {
    let from: String
    let received: String
    let subject: String
    let body: String
    let importance: String
}

class MessageCell: UITableViewCell {
    @IBOutlet weak var deadlineLabel: UILabel!
    @IBOutlet weak var fromLabel: UILabel!
    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var imptLabel: UILabel!
    
    var from: String? {
        didSet {
            fromLabel.text = from
        }
    }
    
    var deadline: String? {
        didSet {
            deadlineLabel.text = deadline
        }
    }
    
    var subject: String? {
        didSet {
            subjectLabel.text = subject
        }
    }
    
    var importance: String? {
        didSet {
            imptLabel.text = importance
        }
    }
}



class MessagesDataSource: NSObject {
    
    var myAccount = Account(_busy_ness: 0, _name: "Hackathon")
    
    let messages: [Message]

    let model = mail_importance_analyzer2()
    var  importance : String = "not important"
    
    init(messages: [JSON]?) {
        var msgArray = [Message]()
        
        if let unwrappedMessages = messages {
            for (message) in unwrappedMessages {
                
                do{
                    let importance = try model.prediction(text: message["body"]["content"].stringValue).label
                    self.importance = importance
                    if importance == "Very Important"{
                        myAccount.busy_ness += 4
                    }
                    else if importance == "Important"{
                        myAccount.busy_ness += 3
                    }
                    else if importance == "Somewhat Important"{
                        myAccount.busy_ness += 2
                    }
                    else if importance == "Not Important"{
                        myAccount.busy_ness += 1
                    }
                    else if importance == "Unrelated"{
                        myAccount.busy_ness += 0
                    }
                }
                catch{
                    fatalError("nobody")
                }
                let newMsg = Message(
                        from: message["from"]["emailAddress"]["name"].stringValue,
                        received: Formatter.dateToString(date: message["receivedDateTime"]),
                        subject: message["subject"].stringValue,
                        body: message["body"]["content"].stringValue,
                        importance: "Importance: "+importance)
                
                msgArray.append(newMsg)
            }
        }

        self.messages = msgArray
    }
}

extension MessagesDataSource: UITableViewDataSource {
    
    
    func detectDate(testString: String) -> Date{
        
        var return_value : Date = Date(timeIntervalSinceNow: 0)
        let dataDetectorService = MKDataDetectorService()
        if let results = dataDetectorService.extractDates(fromTextBody: testString) {
            for result in results {
                return_value = result.data
            }
        }
        return return_value
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("1")
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("2")
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MessageCell.self)) as! MessageCell
        let message = messages[indexPath.row]
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd"
        cell.deadline = "deadline: " + dateformatter.string(from: detectDate(testString: (message.body)))
        if cell.deadline == nil {
            return cell
        }
        cell.from = message.from
        cell.subject = message.subject
        cell.importance = message.importance

        return cell
    }
}
