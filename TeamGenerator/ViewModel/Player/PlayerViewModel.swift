//
//  PlayerViewModelFromPlayer.swift
//  TeamGenerator
//
//  Created by Pedro Lopes on 08/09/2018.
//  Copyright © 2018 Le Team Software. All rights reserved.
//

import Foundation

protocol PlayerViewModel {
    var playerId: Int? { get }
    var playerName: String { get set }
    var playerNumber: String { get set }
    var playerStrength: String { get set }
}

class PlayerViewModelFromPlayer: NSObject, PlayerViewModel {
    // MARK: PlayerViewModel protocol
    var playerId: Int?
    var playerName: String = ""
    var playerNumber: String = ""
    var playerStrength: String = ""
    
    var player: Player?
    
    // MARK: Init
    init(withPlayer player: Player?) {
        super.init()
        
        self.player = player
        
        if let player = player {
            playerId = player.uid
            playerName = player.name
            playerNumber = player.number != nil ? String(player.number!) : ""
            playerStrength = String(player.strength)
        }
    }
}
