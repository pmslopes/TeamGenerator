//
//  PlayerViewModelFromPlayer.swift
//  TeamGenerator
//
//  Created by Pedro Lopes on 08/09/2018.
//  Copyright © 2018 Le Team Software. All rights reserved.
//

import Foundation

class PlayerViewModelFromPlayer: NSObject, PlayerViewModel {
    
    // MARK: PlayerViewModel protocol
    var playerName: String
    var playerStrength: String
    
    // MARK: Init
    init(withPlayer player: Player) {
        self.playerName = player.name
        self.playerStrength = String(player.strength)
    }
}
