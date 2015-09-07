//
//  Randomizer.swift
//  One Lie
//
//  Created by Elex Lee on 2/18/15.
//  Copyright (c) 2015 Elex Lee. All rights reserved.
//

import Foundation

func randomize(inputArray: Array<String>) -> (Array<String>, Int) {
    var scrambledArray: [String] = []
    var answerKey = ([] as [String], 0)
    var randNum = Int(arc4random_uniform(6))
    if randNum == 0 {
        scrambledArray.append(inputArray[0])
        scrambledArray.append(inputArray[1])
        scrambledArray.append(inputArray[2])
        answerKey = (scrambledArray, 2)
    }
    else if randNum == 1 {
        scrambledArray.append(inputArray[0])
        scrambledArray.append(inputArray[2])
        scrambledArray.append(inputArray[1])
        answerKey = (scrambledArray, 1)
    }
    else if randNum == 2 {
        scrambledArray.append(inputArray[1])
        scrambledArray.append(inputArray[0])
        scrambledArray.append(inputArray[2])
        answerKey = (scrambledArray, 2)
    }
    else if randNum == 3 {
        scrambledArray.append(inputArray[1])
        scrambledArray.append(inputArray[2])
        scrambledArray.append(inputArray[0])
        answerKey = (scrambledArray, 1)
    }
    else if randNum == 4 {
        scrambledArray.append(inputArray[2])
        scrambledArray.append(inputArray[0])
        scrambledArray.append(inputArray[1])
        answerKey = (scrambledArray, 0)
    }
    else {
        scrambledArray.append(inputArray[2])
        scrambledArray.append(inputArray[1])
        scrambledArray.append(inputArray[0])
        answerKey = (scrambledArray, 0)
    }
    return answerKey
}