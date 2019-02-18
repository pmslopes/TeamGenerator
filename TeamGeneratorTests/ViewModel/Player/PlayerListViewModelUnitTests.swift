//
//  PlayerListViewModelUnitTests.swift
//  TeamGeneratorTests
//
//  Created by Pedro Lopes on 18/09/2018.
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

class PlayerListViewModelUnitTests: XCTestCase {
    
    var sut: PlayerListViewModelFromPlayers!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = PlayerListViewModelFromPlayers(playerLibrary: MockPlayerLibrary())
        
        for player in sut.playerLibrary!.players! {
            let playerViewModel = PlayerViewModelFromPlayer(withPlayer: player)
            sut.players.value.append(playerViewModel)
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
    
    func testAddPlayer() {
        // Arrange
        let playerToAdd = Players.playerTwo
        let playerViewModel = PlayerViewModelFromPlayer(withPlayer: playerToAdd)
        
        // Act
        var playerAdded: Player?
        let playerExpectation = expectation(description: "Wait for player to be added")
        
        sut.add(playerViewModel: playerViewModel) { (player) in
            playerAdded = player
            playerExpectation.fulfill()
        }
        waitForExpectations(timeout: 1.0)
        
        // Assert
        XCTAssertNotNil(playerAdded, "A second player should be added successfully")
        XCTAssertEqual(playerAdded?.name, playerToAdd.name, "The name of the added player should be correct")
        XCTAssertEqual(playerAdded?.number, playerToAdd.number, "The number of the added player should be nil")
        XCTAssertEqual(playerAdded?.strength, playerToAdd.strength, "The strength of the added player should be correct")
    }
    
    func testAddPlayerWithoutNumber() {
        // Arrange
        let playerToAdd = Players.playerFour
        let playerViewModel = PlayerViewModelFromPlayer(withPlayer: playerToAdd)
        
        // Act
        var playerAdded: Player?
        let playerExpectation = expectation(description: "Wait for player to be added")
        
        sut.add(playerViewModel: playerViewModel) { (player) in
            playerAdded = player
            playerExpectation.fulfill()
        }
        waitForExpectations(timeout: 1.0)
        
        // Assert
        XCTAssertNotNil(playerAdded, "A second player should be added successfully")
        XCTAssertEqual(playerAdded?.name, playerToAdd.name, "The name of the added player should be correct")
        XCTAssertEqual(playerAdded?.number, playerToAdd.number, "The number of the added player should be nil")
        XCTAssertEqual(playerAdded?.strength, playerToAdd.strength, "The strength of the added player should be correct")
    }
    
//    func testAddPlayerWithNumber() {
//        // Arrange
//        let playerToAdd = Players.playerTwo
//
//        // Act
//        var playerAdded: Player?
//        let playerExpectation = expectation(description: "Wait for player to be added")
//        sut.add(name: playerToAdd.name, number: playerToAdd.number, strength: playerToAdd.strength, belongsToClub: playerToAdd.belongsToClub) { (player) in
//            playerAdded = player
//            playerExpectation.fulfill()
//        }
//        waitForExpectations(timeout: 1.0)
//
//        // Assert
//        XCTAssertNotNil(playerAdded, "A second player should be added successfully")
//        XCTAssertEqual(playerAdded?.name, playerToAdd.name, "The name of the added player should be correct")
//        XCTAssertEqual(playerAdded?.number, playerToAdd.number, "The number of the added player should be correct")
//        XCTAssertEqual(playerAdded?.strength, playerToAdd.strength, "The strength of the added player should be correct")
//    }
    
    func testDeletePlayer() {
        // Arrange
        let playerToDelete = Players.playerOne
        
        // Act
        var playerDeleted: Player?

        let playerExpectation = expectation(description: "Wait for player to be deleted")
        sut.delete(indexPath: IndexPath(row: 0, section: 0)) { (player) in
            playerDeleted = player
            playerExpectation.fulfill()
        }
        waitForExpectations(timeout: 1.0)
        
        // Assert
        XCTAssertNotNil(playerDeleted, "A player should be successfully deleted")
        XCTAssertEqual(playerDeleted, playerToDelete, "The deleted player should be correct")
    }
}
