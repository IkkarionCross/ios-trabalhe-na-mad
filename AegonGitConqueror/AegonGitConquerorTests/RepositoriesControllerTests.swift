//
//  RepositoriesControllerTests.swift
//  AegonGitConqueror
//
//  Created by victor-mac on 16/01/17.
//  Copyright © 2017 victor. All rights reserved.
//

import XCTest
@testable import AegonGitConqueror

class RepositoriesControllerTests: XCTestCase {
    
    class RepositoriesDAOStub : RepositoriesDAO {
        
        override func getAllRepositories(forPage: Int) throws -> [GitProject] {
            
            let project:GitProject = GitProject()
            project.desc = "teste"
            project.id   = 123
            project.full_name = "some project"
            project.forks = 20
            project.stars = 20
            
            var projects:[GitProject] = [GitProject]()
            
            projects.append(project)
            
            return projects
        }
        
        override func isSyncronized(page: Int) -> Bool {
            return false
        }
    }
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
