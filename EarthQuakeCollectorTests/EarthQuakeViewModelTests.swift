//
//  EarthQuakeCollectorTests.swift
//  EarthQuakeCollectorTests
//
//  Created by Keval Patel on 2/16/21.
//

import XCTest
@testable import EarthQuakeCollector

class EarthQuakeViewModelTests: XCTestCase {
    var mockManagerWithErrorType: MockEarthQuakeManager!
    var mockManagerWithDataType: MockEarthQuakeManager!
    var viewModel: EarthQuakeViewModel!
    
    override func setUpWithError() throws {
        mockManagerWithErrorType = MockEarthQuakeManager(testType: .error)
        mockManagerWithDataType = MockEarthQuakeManager(testType: .success)
        viewModel = EarthQuakeViewModel(earthQuakeManagementProvider: mockManagerWithErrorType)
    }

    override func tearDownWithError() throws {
        mockManagerWithErrorType = nil
        mockManagerWithDataType = nil
        viewModel = nil
    }

    func testErrorSuceessAndFailure() {
        viewModel = EarthQuakeViewModel(earthQuakeManagementProvider: mockManagerWithErrorType)
        let expectation =  LocalErrors.noMoreDataAvailable
        let wrongExpectation = LocalErrors.dataNotDecodable
        viewModel.fetchEarthQuake { (result) in
            switch result {
            case .success(let earthQuakes):
                XCTAssertNil(earthQuakes)
            case .failure(let ebayError):
                XCTAssertEqual(ebayError,expectation)
                XCTAssertNotEqual(ebayError, wrongExpectation)
            }
        }
    }

    func testDataSuceessAndFailuer() {
        viewModel = EarthQuakeViewModel(earthQuakeManagementProvider: mockManagerWithDataType)
        let expectation =  EarthQuakeMocks.arrayOfEarthQuake
        let wrongExpectation = EarthQuakeMocks.wrongSequenceArrayOfEarthQuake
        viewModel.fetchEarthQuake { (result) in
            switch result {
            case .success(let earthQuakes):
                XCTAssertEqual(earthQuakes, expectation)
                XCTAssertNotEqual(earthQuakes, wrongExpectation)
            case .failure(let ebayError):
                XCTAssertNil(ebayError)
            }
        }
    }

    func testGenerateEarthQuakeDetailModel() throws {
        guard let earthQuakeProperties: EarthQuakeProperties = EarthQuakeMocks.arrayOfEarthQuake.first?.earthQuakeProperties, let wrongEarthQuakeProperties: EarthQuakeProperties = EarthQuakeMocks.arrayOfEarthQuake.last?.earthQuakeProperties else {
            return
        }
        let expectation: EarthQuakeDetailModel = EarthQuakeDetailModel(usgsUrlUrlString: earthQuakeProperties.usgsUrl)
        let wrongExpectation: EarthQuakeDetailModel = EarthQuakeDetailModel(usgsUrlUrlString: wrongEarthQuakeProperties.usgsUrl)
        let actualResult: EarthQuakeDetailModel = viewModel.generateEarthQuakeDetailModel(earthquake: earthQuakeProperties)
        XCTAssertEqual(actualResult, expectation)
        XCTAssertNotEqual(actualResult, wrongExpectation)
    }
}

