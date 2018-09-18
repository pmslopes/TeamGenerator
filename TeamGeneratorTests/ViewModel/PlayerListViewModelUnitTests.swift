//
//  PlayerListViewModelUnitTests.swift
//  TeamGeneratorTests
//
//  Created by Pedro Lopes on 18/09/2018.
//  Copyright © 2018 Le Team Software. All rights reserved.
//

import XCTest
@testable import TeamGenerator

class PlayerListViewModelUnitTests: XCTestCase {

    class MockPlayerLibrary: PlayerLibrary {

        func fetch(completion: @escaping (([Player]) -> Void)) {
            
        }
        
        func add(_ player: Player) {
            
        }
        
        func remove(_ playerIndex: Int) {
            
        }
        
        func update(_ player: Player) {
            
        }
    }
    
    var sut: PlayerListViewModelFromPlayers!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = PlayerListViewModelFromPlayers()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        super.tearDown()
    }

    func testExample() {
        // Arrange
        sut.databasePlayerLibrary = MockPlayerLibrary()
        
        // Act
        
        // Assert
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
