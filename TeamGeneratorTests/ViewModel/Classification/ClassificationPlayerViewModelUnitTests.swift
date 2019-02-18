//
//  ClassificationPlayerViewModelUnitTests.swift
//  TeamGeneratorTests
//
//  Created by CTW00169 on 13/11/2018.
//  Copyright © 2018 Le Team Software. All rights reserved.
//

import XCTest
@testable import TeamGenerator

fileprivate class MockPlayerLibrary: PlayerLibrary {
    var players: [Player]? = [Players.playerOne]
    
    func fetch(completion: @escaping (([Player]) -> Void)) {
        completion(players!)
    }
    
    func fetch(id: Int?, completion: @escaping ((Player?) -> Void)) {
        guard let id = id else {
            completion(nil)
            return
        }
        
        let player = players?.filter({ (player) -> Bool in
            return player.uid == id
        }).first
        
        completion(player)
    }
    
    func add(_ player: Player, completion: @escaping ((Player) -> Void)) {
        players?.append(player)
        completion(player)
    }
    
    func remove(_ playerIndex: Int, completion: @escaping ((Player) -> Void)) {
        if playerIndex < players!.count {
            let player = players!.remove(at: playerIndex)
            completion(player)
        }
    }
    
    func update(_ player: Player, completion: @escaping ((Player) -> Void)) {
        var existingPlayer: Player?
        for currentPlayer in players! {
            if currentPlayer == player {
                existingPlayer = currentPlayer
                break
            }
        }
        
        if var existingPlayer = existingPlayer {
            existingPlayer.name = player.name
            existingPlayer.strength = player.strength
            
            completion(player)
        }
    }
}

class ClassificationPlayerViewModelUnitTests: XCTestCase {
    var sut: ClassificationViewModelFromPlayers!

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = ClassificationViewModelFromPlayers(playerLibrary: MockPlayerLibrary())
        
        for player in sut.playerLibrary!.players! {
            let classificationPlayerViewModel = ClassificationPlayerViewModelFromPlayer(withPlayer: player)
            sut.players.value.append(classificationPlayerViewModel)
        }
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        super.tearDown()
    }

    func testFetchPlayers() {
        // Arrange
        
        // Act
        var playersFetched: [Player]?
        let playersExpectation = expectation(description: "Wait for players to be fetched")
        sut.fetch { (players) in
            playersFetched = players
            playersExpectation.fulfill()
        }
        waitForExpectations(timeout: 1.0)
        
        // Assert
        XCTAssertNotNil(playersFetched, "Players should be fetch successfully")
        for playerFetched in playersFetched! {
            XCTAssertEqual(playerFetched, Players.playerOne, "The name of the added player should be correct")
        }
    }
}
