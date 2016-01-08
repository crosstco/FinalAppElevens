//
//  Card.swift
//  Elevens
//
//  Created by Colin on 12/2/15.
//  Copyright © 2015 ccross. All rights reserved.
//

import UIKit

class Card: NSObject {
    
    var rank : String
    var suit : String
    var value : Int

    
    //creates a card that has a rank, suit, and value in a card game.
    init(cardRank : String, cardSuit : String, cardValue : Int) {
        rank = cardRank
        suit = cardSuit
        value = cardValue
    }
    
    //checks if this card is equal to another card
    func equals(other : Card) -> Bool {
        return self.rank == other.rank && self.suit == other.suit && self.value == other.value
    }
    
    
}
