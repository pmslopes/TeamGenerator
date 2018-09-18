//
//  PlayerViewModelFromPlayer.swift
//  TeamGenerator
//
//  Created by Pedro Lopes on 08/09/2018.
//  Copyright © 2018 Le Team Software. All rights reserved.
//

import Foundation

protocol PlayerViewModel {
    var playerName: String { get }
    var playerStrength: String { get }
}

class PlayerViewModelFromPlayer: NSObject, PlayerViewModel {
    
    // MARK: PlayerViewModel protocol
    var playerName: String
    var playerStrength: String
    
    // MARK: Init
    override init() {
        playerName = ""
        playerStrength = ""
    }
    
    init(withPlayer player: Player) {
        playerName = player.name
        playerStrength = String(player.strength)
    }
}
