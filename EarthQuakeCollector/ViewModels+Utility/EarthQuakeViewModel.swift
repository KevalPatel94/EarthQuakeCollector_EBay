//
//  EarthQuakeViewModel.swift
//  EarthQuakeCollector
//
//  Created by Keval Patel on 2/16/21.
//


import Foundation
import UIKit

/// `EarthQuakeViewModel` is responsible for providing data to viewcontroller, it gets data from `EarthQuakeDataManager`
///- Note: In this application we have pretty simple business logic so ViewModel looks pretty simple but If we have more business logic we will start creating new sub modules.ex: struct or classes and we will pass their result to ViewController via viewmodel
class EarthQuakeViewModel {
    var listOfEarthQuakes: [EarthQuake] = []
    let earthQuakeManagementProvider: EarthQuakeManagementProvider
    init(earthQuakeManagementProvider: EarthQuakeManagementProvider) {
        self.earthQuakeManagementProvider = earthQuakeManagementProvider
    }
    
    /// `fetchEarthQuake` fetches `[EarthQuakes]` from `EarthQuakeManagementProvider`
    /// - Parameter completion: `@escaping((Result<[EarthQuakes]?, EbayError>)) -> Void)`
    func fetchEarthQuake(completion: @escaping((Result<[EarthQuake]?, EbayError>)) -> Void) {
        earthQuakeManagementProvider.getEarthQuakes {[weak self] (result) in
            switch result {
            case .success(let earthQuakes):
                self?.listOfEarthQuakes.append(contentsOf: earthQuakes)
                completion(.success(self?.listOfEarthQuakes))
            case .failure(let ebayError):
                completion(.failure(ebayError))
            }
        }
    }
}

// MARK: - Build EarthQuakeDetailModel
extension EarthQuakeViewModel {
    /// `generateEarthQuakeDetailModel`  generates `EarthQuakeDetailModel`
    /// - Parameter earthquake: `EarthQuakeProperties`
    /// - Returns: `EarthQuakeDetailModel`
    /// - Note: Small exmple of `Builder Design Pattern`. Usually we have whole array of one model and we convert then in another type of model array.
    func generateEarthQuakeDetailModel(earthquake: EarthQuakeProperties) -> EarthQuakeDetailModel {
        return EarthQuakeDetailModel(usgsUrlUrlString: earthquake.usgsUrl)
    }
}
