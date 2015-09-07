// Playground - noun: a place where people can play

import UIKit

func postInfo(#userName: String, #truth: String, #truth2: String, #lie: String) {
    let session = NSURLSession.sharedSession()
    
    let request = NSMutableURLRequest()
    request.HTTPMethod = "POST"
    request.URL = NSURL(string: "http://tradecraftmessagehub.com/onelie/test2")
    
    var factsDictionary: [String:String] = [
        "Truth": truth, "Truth2": truth2, "Lie": lie
    ]
    var err: NSError?
    var newFactsDictionary = NSJSONSerialization.dataWithJSONObject(factsDictionary, options: nil, error: &err)
    println(newFactsDictionary)
    
    
    
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
        // FIXME: This no longer uses the correct data!
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
    request.URL = NSURL(string: "http://tradecraftmessagehub.com/onelie/test2")
    
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