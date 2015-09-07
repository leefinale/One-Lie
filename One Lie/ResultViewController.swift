//
//  ResultViewController.swift
//  One Lie
//
//  Created by Elex Lee on 2/17/15.
//  Copyright (c) 2015 Elex Lee. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    var userResult: UserWithFacts!
    var result: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultLabel.text = result
        // Do any additional setup after loading the view.
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
