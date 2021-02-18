//
//  EarthQuakeCollectorUITests.swift
//  EarthQuakeCollectorUITests
//
//  Created by Keval Patel on 2/16/21.
//

import XCTest
@testable import EarthQuakeCollector

class EarthQuakeCollectorUITests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }
    
    func testNoInternetConnection() {
        /// Please comment this guard statement and turn of internet before running this test. It always give linker error if i try to use any thing from Unit test framework or Project.
//        guard !Internet.isConnected() else {
//            return
//        }
        let app = XCUIApplication()
        app.launch()
        
        let alert = app.alerts["Please connect to Internet"]
        let alertTitle = alert.staticTexts[Mocks.noInternetAlertMessage]
        let alertButton = alert.buttons[Mocks.noInternetAlertButtonTitle]
        XCTAssertTrue(alertTitle.exists)
        XCTAssertTrue(alertButton.exists)
        alert.buttons[Mocks.noInternetAlertButtonTitle].tap()
        XCTAssertFalse(alertTitle.exists)
        XCTAssertFalse(alertButton.exists)
    }

    /// I will not let this run, since it can fail
    func ExistanceCellEntry() throws {
        /// Since i am not able to use project target, due to some kind of linker errors this might not pass.
        /// We can set upthe same structure as we did in  ```EarthQuakeViewModelTests``` and test the existence of each cell based on our mocks
        let app = XCUIApplication()
        app.launch()
        let titleLable = app.tables.staticTexts["M 0.8 - 5km WNM of The Geysers, CA"]
        let detailLabel = app.tables.staticTexts["At 5km WNM of The Geysers, CA"]
        XCTAssertTrue(titleLable.exists)
        XCTAssertTrue(detailLabel.exists)
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
