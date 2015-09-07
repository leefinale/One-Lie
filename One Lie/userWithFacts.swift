//
//  NameBook.swift
//  One Lie
//
//  Created by Elex Lee on 2/17/15.
//  Copyright (c) 2015 Elex Lee. All rights reserved.
//

import UIKit

class UserWithFacts: NSObject {

    let userName: String
    let facts: Array<String> = ["Truth", "Truth2", "Lie"]
    
    init(userName: String, facts: [String]) {
        self.userName = userName
        self.facts = facts
        super.init()
    }
}
