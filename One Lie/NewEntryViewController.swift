//
//  NewEntryViewController.swift
//  One Lie
//
//  Created by Elex Lee on 2/17/15.
//  Copyright (c) 2015 Elex Lee. All rights reserved.
//

import UIKit

class NewEntryViewController: UIViewController {
    
    var delegate: NewEntryViewControllerDelegate?
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var firstTruthTextField: UITextField!
    @IBOutlet weak var secondTruthTextField: UITextField!
    @IBOutlet weak var lieTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


    @IBAction func submitUserNameButton(sender: AnyObject) {
        self.delegate?.newEntryCreated(self.userNameTextField.text, truthOne: self.firstTruthTextField.text, truthTwo: self.secondTruthTextField.text, lie: self.lieTextField.text)
        postMessage(inputName: self.userNameTextField.text, inputTruth: self.firstTruthTextField.text, inputTruth2: self.secondTruthTextField.text, inputLie: self.lieTextField.text)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func postInfo(#userName: String, truth: String, truth2: String, lie: String) -> NSData {
        let session = NSURLSession.sharedSession()
        
        let request = NSMutableURLRequest()
        request.HTTPMethod = "POST"
        request.URL = NSURL(string: "http://tradecraftmessagehub.com/onelie/test2")
        
        var factsDictionary: [String:String] = [
            "Truth": truth, "Truth2": truth2, "Lie": lie
        ]
        var err: NSError?
        var newFactsDictionary = NSJSONSerialization.dataWithJSONObject(factsDictionary, options: nil, error: &err)
        let messageText = NSString(data: newFactsDictionary!, encoding: NSUTF8StringEncoding)
        var toBePosted: [String:String] = ["user_name":userName, "message_text":messageText!]
        var finalPost = NSJSONSerialization.dataWithJSONObject(toBePosted, options: nil, error: &err)
        return finalPost!
    }
    
    func postMessage(#inputName: String, inputTruth: String, inputTruth2: String, inputLie: String) {
        
        var session = NSURLSession.sharedSession()
        
        let bodyData = self.postInfo(userName: inputName, truth: inputTruth, truth2: inputTruth2, lie: inputLie)
        
        let request = NSMutableURLRequest()
        request.URL = NSURL(string: "http://tradecraftmessagehub.com/onelie/v1")
        request.HTTPBody = bodyData
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        var task = session.dataTaskWithRequest(request)
        task.resume()
    }
    
}

protocol NewEntryViewControllerDelegate: NSObjectProtocol {
    func newEntryCreated(name: String, truthOne: String, truthTwo: String, lie: String)
}


