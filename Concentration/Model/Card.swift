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
    /// is the card face is up so the user can see it's content or not?
    var isFacedUp: Bool = false
    
    /// did the user see the content of this card before or not
    var isFacedUpBefore: Bool = false
    
    /// did the user pick out this card's match
    var isMatched: Bool = false
    
    /// Identifier number ranges from 0 - totalNumberOfCards
    let identifier: Int
    
    /// This is the starting point of the card's identifier, it's set to -1 to make sure that the range starts from 0
    private static var identifierFactory = -1
    
    /// generates a unique Identifier to each card upon initialization of the Card struct
    private static func getUniqueIdentifier() -> Int
    {
        identifierFactory += 1
        return identifierFactory
    }
    
    static func ==(lhs: Card, rhs: Card) -> Bool
    {
        return lhs.identifier == rhs.identifier
    }
    
    init()
    {
        self.identifier = Card.getUniqueIdentifier()
    }
}
