//
//  MasterViewController.swift
//  One Lie
//
//  Created by Elex Lee on 2/16/15.
//  Copyright (c) 2015 Elex Lee. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController, NewEntryViewControllerDelegate {

    var objects = [
        UserWithFacts(userName: "", facts: ["", "", ""])
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getMessages()
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                let object = objects[indexPath.row]
                let destinationDetailViewController = segue.destinationViewController as DetailViewController
            destinationDetailViewController.detailItem = object
            }
        }
        else if segue.identifier == "Add" {
            let entryVC = segue.destinationViewController as NewEntryViewController
            entryVC.delegate = self
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell

        let object = objects[indexPath.row]
        cell.textLabel!.numberOfLines = 0
        cell.textLabel!.text = "\(object.userName)"
        return cell
    }
    
    @IBAction func unwindToThisViewController(segue : UIStoryboardSegue) {
        
    }
    
    func reloadTableUI() {
        self.tableView.reloadData()
    }
    
    func newEntryCreated(name: String, truthOne: String, truthTwo: String, lie: String) {
        var tempUserFact = UserWithFacts(userName: name, facts: [truthOne, truthTwo, lie])
        println(tempUserFact)
        objects.insert(tempUserFact, atIndex: 0)
        reloadTableUI()
    }
    
    // MARK: - Network
    
    func alertWithError(error : NSError) {
        let alertController = UIAlertController(
            title: "Error",
            message: error.description,
            preferredStyle: UIAlertControllerStyle.Alert
        )
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func messagesFromNetworkResponseData(responseData : NSData) -> Array<UserWithFacts>? {
        var serializationError : NSError?
        let messageAPIDictionaries = NSJSONSerialization.JSONObjectWithData(
            responseData,
            options: nil,
            error: &serializationError
            ) as Array<Dictionary<String, String>>
        
        if let serializationError = serializationError {
            alertWithError(serializationError)
            return nil
        }
        
        var messages = messageAPIDictionaries.map({ (messageAPIDictionary) -> UserWithFacts in
            let messageText = messageAPIDictionary["message_text"]!
            let messageData = messageText.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
            let messageFacts = NSJSONSerialization.JSONObjectWithData(messageData!, options: nil, error: &serializationError) as Dictionary<String, String>
            if let serializationError = serializationError {
                self.alertWithError(serializationError)
            }
            let userName = messageAPIDictionary["user_name"]!
            let arrayOfFacts = [messageFacts["Truth"]!, messageFacts["Truth2"]!, messageFacts["Lie"]!]
            return UserWithFacts(userName: userName, facts: arrayOfFacts)// messageFacts!)
        })
        
        return messages
    }
    
    func getMessages() {
        // opens a new session
        let session = NSURLSession.sharedSession()
        
        // configuring actions that we will be using across the network
        let request = NSMutableURLRequest()
        request.HTTPMethod = "GET"
        request.URL = NSURL(string: "http://tradecraftmessagehub.com/onelie/v1")
        
        // executing the gameplan
        let task = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) in
            NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
                // below is what happens when we get information back
                if let error = error {
                    self.alertWithError(error)
                } else if let messages = self.messagesFromNetworkResponseData(data) {
                    self.objects = messages
                    self.tableView.reloadData()
                }
            }
        })
        
        task.resume()
    }
}