//
//  PassFail.swift
//  One Lie
//
//  Created by Elex Lee on 2/18/15.
//  Copyright (c) 2015 Elex Lee. All rights reserved.
//

import Foundation

func PassFail(choice: String, key: Array<String>) -> String {
    if choice == key[2] {
        return "Correct"
    }
    else {
        return "Incorrect"
    }
    
}