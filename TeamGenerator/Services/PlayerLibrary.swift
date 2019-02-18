//
//  PlayerLibrary.swift
//  TeamGenerator
//
//  Created by Pedro Lopes on 07/09/2018.
//  Copyright © 2018 Le Team Software. All rights reserved.
//

import Foundation

protocol PlayerLibrary {
    var players: [Player]? { get }
    
    func fetch(completion: @escaping (([Player]) -> Void))
    func fetch(id: Int?, completion: @escaping ((Player?) -> Void))
    func add(_ player: Player, completion: @escaping ((Player) -> Void))
    func remove(_ playerIndex: Int, completion: @escaping ((Player) -> Void))
    func update(_ player: Player, completion: @escaping ((Player) -> Void))
}
