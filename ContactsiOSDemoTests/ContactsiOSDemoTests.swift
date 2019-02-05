//
//  ContactsiOSDemoTests.swift
//  ContactsiOSDemoTests
//
//  Created by Mukesh Verma on 31/01/19.
//  Copyright © 2019 Mukesh Verma. All rights reserved.
//

import XCTest
@testable import ContactsiOSDemo

class ContactsiOSDemoTests: XCTestCase {

    var viewModel : ContactListViewModel! = ContactListViewModel()
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewModel.reloadTable = {
            
        }
         viewModel.loadAllContactData()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel = nil
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        if viewModel.diccMobileData.count == 0
        {
            XCTFail("You have not inserted data yet")
        }
       
        XCTAssertNotNil(viewModel.diccMobileData)
        XCTAssertNotNil(viewModel.sortedKeys)
        XCTAssertGreaterThan(viewModel.diccMobileData.count, 0, "You have not inserted data")
        XCTAssertNotNil(viewModel.getRecordBasedOnSection(section: 0, row: 0), "Record should not be nil")
        XCTAssertGreaterThan(viewModel.getNumberOfRowsForForSection(section: 0), 0, "record count should be greater than 0")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
