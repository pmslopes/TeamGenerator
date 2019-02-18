//
//  Players.swift
//  TeamGeneratorTests
//
//  Created by CTW00169 on 13/11/2018.
//  Copyright © 2018 Le Team Software. All rights reserved.
//

import Foundation
@testable import TeamGenerator

struct Players {
    static let playerOne = Player(uid: 0,
                                  name: "One",
                                  number : 1,
                                  strength: 54,
                                  belongsToClub: false,
                                  games: 3,
                                  wins: 1,
                                  ties: 0,
                                  losses: 2)
    
    static let playerTwo = Player(uid: 1,
                                  name: "Two",
                                  number : 2,
                                  strength: 74,
                                  belongsToClub: false,
                                  games: 3,
                                  wins: 3,
                                  ties: 0,
                                  losses: 0)
    
    static let playerThree = Player(uid: 2,
                                    name: "Three",
                                    number : 3,
                                    strength: 23,
                                    belongsToClub: false,
                                    games: 3,
                                    wins: 2,
                                    ties: 0,
                                    losses: 1)
    
    static let playerFour = Player(uid: 3,
                                  name: "Four",
                                  number : nil,
                                  strength: 74,
                                  belongsToClub: false,
                                  games: 3,
                                  wins: 3,
                                  ties: 0,
                                  losses: 0)
}
