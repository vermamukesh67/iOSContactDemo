//
//  ContactDetailsTest.swift
//  ContactsiOSDemoTests
//
//  Created by Verma Mukesh on 01/02/19.
//  Copyright © 2019 Mukesh Verma. All rights reserved.
//

import XCTest
@testable import ContactsiOSDemo
class ContactDetailsTest: XCTestCase {

    var viewModel : ContactDetailViewModel! = ContactDetailViewModel()
    
    
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel = nil
        
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        var validation = viewModel.ValidateDetailsScreen(strFName: "Varma", strlastName: "Mukesh", strMo: "7990362110")
        XCTAssertNotNil(validation, "Should not be nil")
        
        XCTAssertTrue(validation.0)
        
        validation = viewModel.ValidateDetailsScreen(strFName: nil, strlastName: "Mukesh", strMo: "7990362110")
        
        XCTAssertFalse(validation.0, validation.1)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
