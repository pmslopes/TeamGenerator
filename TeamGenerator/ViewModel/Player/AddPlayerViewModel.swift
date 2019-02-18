//
//  AddPlayerViewModel.swift
//  TeamGenerator
//
//  Created by Pedro Lopes on 18/09/2018.
//  Copyright © 2018 Le Team Software. All rights reserved.
//

import Foundation

class AddPlayerViewModel: NSObject, PlayerViewModel {    
    var databasePlayerLibrary: PlayerLibrary?
    
    // MARK: PlayerViewModel protocol
    var numberOfPlayers: Int
    var playerName: String
    var playerStrength: String
    var playerBelongsToClub: Bool
    
    // MARK: Init
    init(numberOfPlayers: Int) {
        self.numberOfPlayers = numberOfPlayers
        self.playerName = ""
        self.playerStrength = ""
        self.playerBelongsToClub = false
        
        self.databasePlayerLibrary = DatabasePlayerLibrary()
    }
    
    func save(name: String, strength: String, belongsToClub: Bool) {
        guard let strength = Int(strength) else {
            return
        }
        
        let player = Player(uid: numberOfPlayers, name: name, strength: strength, belongsToClub: belongsToClub)
        databasePlayerLibrary?.add(player)
    }
}
