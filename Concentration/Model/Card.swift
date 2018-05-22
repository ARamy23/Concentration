//
//  Card.swift
//  Concentration
//
//  Created by Ahmed Ramy on 5/21/18.
//  Copyright © 2018 Ahmed Ramy. All rights reserved.
//

import Foundation

struct Card
{
    var isFacedUp: Bool = false
    
    //will set this after turn has ended
    var isFacedUpBefore: Bool = false
    
    
    var isMatched: Bool = false
    let identifier: Int
    
    static var identifierFactory = -1
    
    static func getUniqueIdentifier() -> Int
    {
        identifierFactory += 1
        return identifierFactory
    }
    
    init()
    {
        self.identifier = Card.getUniqueIdentifier()
    }
}
