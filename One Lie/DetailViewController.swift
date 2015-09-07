//
//  DetailViewController.swift
//  One Lie
//
//  Created by Elex Lee on 2/16/15.
//  Copyright (c) 2015 Elex Lee. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var oneButton: UIButton!
    @IBOutlet weak var twoButton: UIButton!
    @IBOutlet weak var threeButton: UIButton!

    var detailItem: UserWithFacts!
    var result: String = ""
    var correctAnswer: String = ""
    var key: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.correctAnswer = detailItem.facts[2]
        var newArray = randomize(detailItem.facts)
        self.key = newArray.1
        oneButton.setTitle(newArray.0[0], forState: .Normal)
        twoButton.setTitle(newArray.0[1], forState: .Normal)
        threeButton.setTitle(newArray.0[2], forState: .Normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Segues
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "choiceOne" {
            var resultVC = segue.destinationViewController as ResultViewController
            resultVC.userResult = detailItem
            
            if key == 0 {
                result = "Correct"
                resultVC.result = result
            }
            else {
                result = "Incorrect"
                resultVC.result = result
            }
        }
        if segue.identifier == "choiceTwo" {
            var resultVC = segue.destinationViewController as ResultViewController
            resultVC.userResult = detailItem
            if key == 1 {
                result = "Correct"
                resultVC.result = result
            }
            else {
                result = "Incorrect"
                resultVC.result = result
            }
        }
        if segue.identifier == "choiceThree" {
            var resultVC = segue.destinationViewController as ResultViewController
            resultVC.userResult = detailItem
            if key == 2 {
                result = "Correct"
                resultVC.result = result
            }
            else {
                result = "Incorrect"
                resultVC.result = result
            }
        }
    }
}