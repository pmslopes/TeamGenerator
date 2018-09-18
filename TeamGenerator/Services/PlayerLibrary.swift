//
//  PlayerLibrary.swift
//  TeamGenerator
//
//  Created by Pedro Lopes on 07/09/2018.
//  Copyright © 2018 Le Team Software. All rights reserved.
//

import Foundation

enum PlayerLibraryNotifications {
    static let PlayerLibraryPlayerAdded    = "PlayerLibraryPlayerAdded"
    static let PlayerLibraryPlayerRemoved  = "PlayerLibraryPlayerRemoved"
    static let PlayerLibraryPlayerUpdated  = "PlayerLibraryPlayerUpdated"
}

protocol PlayerLibrary {
    func fetch(completion: @escaping (([Player]) -> Void))
    func add(_ player: Player) // posts PlayerLibraryPlayerAdded notifications    
    func remove(_ playerIndex: Int) // posts PlayerLibraryPlayerRemoved notifications
    func update(_ player: Player) // posts PlayerLibraryPlayerUpdated notifications
}
