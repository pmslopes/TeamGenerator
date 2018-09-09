//
//  PlayerListViewModelFromPlayers.swift
//  TeamGenerator
//
//  Created by Pedro Lopes on 08/09/2018.
//  Copyright © 2018 Le Team Software. All rights reserved.
//

import Foundation

class PlayerListViewModelFromPlayers: NSObject, PlayerListViewModel {
    
    let databasePlayerLibrary = DatabasePlayerLibrary()
    
    // MARK: PlayerViewModel protocol
    var players: Dynamic<[PlayerViewModel]> = Dynamic([])
    
    // MARK: Init
    init(withPlayers playerList: [Player]) {
        for player in playerList {
            let playerViewModel = PlayerViewModelFromPlayer(withPlayer: player)
            players.value.append(playerViewModel)
        }
        
        super.init()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(addedPlayer(_:)),
                                               name: NSNotification.Name(rawValue: PlayerLibraryNotifications.PlayerLibraryPlayerAdded),
                                               object: nil)
    }
    
    override init() {
        super.init()
        
        databasePlayerLibrary.fetch { (playerList) in
            for player in playerList {
                let playerViewModel = PlayerViewModelFromPlayer(withPlayer: player)
                self.players.value.append(playerViewModel)
            }
        }
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(addedPlayer(_:)),
                                               name: NSNotification.Name(rawValue: PlayerLibraryNotifications.PlayerLibraryPlayerAdded),
                                               object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func add(name: String, strength: Int, belongsToClub: Bool) {
        let player = Player(uid: players.value.count, name: name, strength: strength, belongsToClub: belongsToClub)
        databasePlayerLibrary.add(player)
    }
    
    func delete(indexPath: IndexPath) {
        players.value.remove(at: indexPath.row)
    }
    
    // MARK: Notifications
    @objc func addedPlayer(_ notification: NSNotification) {
        guard let userInfo = notification.userInfo, let player = userInfo["player"] as! Player? else {
            return
        }
        
        let playerViewModel = PlayerViewModelFromPlayer(withPlayer: player)
        players.value.append(playerViewModel)
    }
}
