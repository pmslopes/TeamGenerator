//
//  PlayerListViewModel.swift
//  TeamGenerator
//
//  Created by Pedro Lopes on 08/09/2018.
//  Copyright © 2018 Le Team Software. All rights reserved.
//

import Foundation

protocol PlayerListViewModel {
    var players: Dynamic<[PlayerViewModel]> { get }
    
    func add(name: String, strength: Int, belongsToClub: Bool)
    func delete(indexPath: IndexPath)
}
