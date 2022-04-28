//
//  mailViewController.swift
//  iOS 6
//
//  Created by Victor Lobe on 25.04.20.
//  Copyright © 2020 Victor Lobe. All rights reserved.
//

import UIKit
import Postal

class mailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var mailListTableView: UITableView!
    @IBOutlet var lastFetchedLabel: UILabel!
    @IBOutlet var loadingSpinner: UIActivityIndicatorView!
    @IBOutlet var loadMailsLabell: UILabel!
    
    var emails: [[String]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkMails()
    }
    
    @IBAction func reloadMails(_ sender: Any) {
        checkMails()
    }
    
    @objc func checkMails() {
        lastFetchedLabel.isHidden = true
        loadingSpinner.isHidden = false
        loadMailsLabell.isHidden = false
        emails.removeAll()
        let postal = Postal(configuration: .icloud(login: iCloudUsername, password: iCloudPassword))
        postal.connect { result in
            switch result {
            case .success:
                print("success")
            case .failure(let error):
                print("error: \(error)")
            }
        }
        
        postal.fetchLast("INBOX", last: 90, flags: [ .fullHeaders, .body ], onMessage: { email in
            print("Mail found!")
                var mailBody = ""
                var sender = ""
                var receivedDate = "01.01.1970"
                if self.bodyText(body: email.body!) == nil {} else {
                 mailBody = String(self.bodyText(body: email.body!)!)
                }
                if email.header?.from[0].displayName == "" {
                    sender = email.header?.from[0].email as! String
                } else {
                    sender = email.header?.from[0].displayName as! String
                }
         //   receivedDate = email.internalDate
                let mailArray = [sender, email.header!.subject, mailBody, receivedDate]
                self.emails.append(mailArray)
            self.mailListTableView.reloadData()
        }, onComplete: {_ in 
            self.lastFetchedLabel.isHidden = false
            self.loadingSpinner.isHidden = true
            self.loadMailsLabell.isHidden = true
        })
    }
    
    func bodyText(body: MailPart) -> String? {
        for part in body.allParts {
            if part.mimeType.type == "text" && part.mimeType.subtype ==  "plain" {
                if let decodedData = part.data?.decodedData {
                    let decodedString = NSString(data: decodedData, encoding: String.Encoding.utf8.rawValue) as String!

                    return decodedString
                }
            }
        }

        return nil
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mailListTableViewCell", for: indexPath) as! mailListTableViewCell
        cell.absenderLabel.text = emails[indexPath.row][0]
        cell.betreffLabel.text = emails[indexPath.row][1]
        cell.bodyLabel.text = emails[indexPath.row][2]
        
        return cell
    }
    
}
