//
//  PaginatorTests.swift
//  EarthQuakeCollectorTests
//
//  Created by Keval Patel on 2/17/21.
//

import Foundation
import XCTest
@testable import EarthQuakeCollector
 
class PaginatorTests: XCTestCase {
    var paginator: Paginator!
    override func setUpWithError() throws {
        paginator = Paginator(offset: 1, count: Int.min)
    }

    override func tearDownWithError() throws {
        paginator = nil
    }

    func testSuccessUpdatePage() {
        /// Please make sure to check the limit in ```GlobalConstants```
        XCTAssertEqual(paginator.isFirstPage, true)
        paginator.updatePage(newCount: 31)
        XCTAssertEqual(paginator.isFirstPage, false)
        XCTAssertEqual(paginator.isLastPage, false)
        XCTAssertEqual(paginator.nextOffSet, "32")
    }
    
    func testFailureUpdatePage() {
        /// Please make sure to check the limit in ```GlobalConstants```
        paginator.updatePage(newCount: 31)
        XCTAssertNotEqual(paginator.isFirstPage, true)
        XCTAssertNotEqual(paginator.isLastPage, true)
        XCTAssertNotEqual(paginator.nextOffSet, "20")
    }

    func testSuccessDidLoadDataBase() {
        XCTAssertEqual(paginator.shoulGetDataFromDataBase, true)
        paginator.didLoadDataBase(true)
        XCTAssertEqual(paginator.shoulGetDataFromDataBase, false)
        paginator.didLoadDataBase(false)
        XCTAssertEqual(paginator.shoulGetDataFromDataBase, true)
    }
    
    func testFailureDidLoadDataBase() {
        XCTAssertNotEqual(paginator.shoulGetDataFromDataBase, false)
        paginator.didLoadDataBase(true)
        XCTAssertNotEqual(paginator.shoulGetDataFromDataBase, true)
        paginator.didLoadDataBase(false)
        XCTAssertNotEqual(paginator.shoulGetDataFromDataBase, false)
    }
}

