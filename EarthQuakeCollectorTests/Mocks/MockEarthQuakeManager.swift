//
//  MockEarthQuakeManager.swift
//  EarthQuakeCollectorTests
//
//  Created by Keval Patel on 2/16/21.
//

import Foundation
@testable import EarthQuakeCollector

enum TestType {
    case error
    case success
}

struct MockEarthQuakeManager: EarthQuakeManagementProvider {
    private var testType: TestType
    init(testType: TestType) {
        self.testType = testType
    }
    
    func getEarthQuakes(completion: @escaping ((Result<[EarthQuake], EbayError>)) -> Void) {
        if testType == .success{
            completion(.success(EarthQuakeMocks.arrayOfEarthQuake))
        }
        else if testType == .error {
            completion(.failure(LocalErrors.noMoreDataAvailable))
        }
    }
}
