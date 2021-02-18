//
//  EarthQuakeManager.swift
//  EarthQuakeCollector
//
//  Created by Keval Patel on 2/16/21.
//

import Foundation

//MARK: - 'Manager'
protocol Manager {
    ///FYI: Its usually used to introduce some default properties and rules that all Manager should follow. The ```bootStrap()``` is the best example in reactive programing. It handles the Hot observables.
}

//MARK:- 'EarthQuakeManagementProvider'
/// `EarthQuakeManagementProvider` is a layer between any Manager and ViewModel.
/// - Note: This clss is used to accommodate is used to accomodate `Strategy Design Pattern`.
protocol EarthQuakeManagementProvider {
    func getEarthQuakes(completion: @escaping((Result<[EarthQuake], EbayError>)) -> Void)
}

//MARK:- EarthQuakeManager
/// `EarthQuakeManagementProvider`is a `singleton`, which will responsible for providing data to viewmodel.
class EarthQuakeManager: EarthQuakeManagementProvider {
    
    private var paginator = Paginator(offset: 1, count: Int.min)
    /// We can create enum and genrate url by replacing its parameter but since there is only one, we can have variable
    private let getEarthQuakeUrlString: String = "https://earthquake.usgs.gov/fdsnws/event/1/query?format=geojson&starttime=\(Date().lastDateString)&endtime=\(Date().todayDateString)&limit=\(GlobalConstants.limit)&offset="
    
    static let shared = EarthQuakeManager()
    private let dataManager = EarthQuakeDataManager.shared
    private let webManger = EarthQuakeWebManager.shared
    
    private init () {}
    
    /// `getEarthQuakes` will get earthquake by communicating to `EarthQuakeWebManager` and `EarthQuakeDataManager`
    /// - Parameter completion: It is of type `(Result<[EarthQuakes], EbayError>)) -> Void`
    /// - Important: It is also responsible to handle scenarios when there is no internet connction
    func getEarthQuakes(completion: @escaping((Result<[EarthQuake], EbayError>)) -> Void) {
        let isFirstPage: Bool = paginator.isFirstPage
        // If there is no internet connection
        if !Internet.isConnected() {
            getDataFromLocalDataBase { (result) in
                switch result {
                case .success(let earthQuakesArray):
                    completion(.success(earthQuakesArray))
                case .failure(let ebayError):
                    completion(.failure(ebayError))
                }
            }
        }
        
        // Use case If It is the lastPage
        guard !paginator.isLastPage else {
            completion(.failure(LocalErrors.noMoreDataAvailable))
            return
        }
        
        let urlString: String = getEarthQuakeUrlString + paginator.nextOffSet
        // Get data from WebManger
        webManger.fetchEarthQuakeList(urlString: urlString,
                            expectingReturnType: EarthQuakeFeatures.self) { [weak self] (result) in
            switch result {
            case .success(let earthQuakeFeatures):
                self?.paginator.didLoadDataBase(false)
                self?.paginator.updatePage(newCount: earthQuakeFeatures.metaData.count)
                self?.dataManager.saveData(earthQuakes: earthQuakeFeatures.earthQuakes,
                                           isFirstPage: isFirstPage)
                completion(.success(earthQuakeFeatures.earthQuakes))
            case .failure(let ebayError):
                completion(.failure(ebayError))
            }
        }
    }
}

//MARK: - Call From LocalDataBase
extension EarthQuakeManager {
    
    /// `getDataFromLocalDataBase` will get data from local database. It includes communication with `EarthQuakeDataManager`
    /// - Parameter completion: `@escaping((Result<[EarthQuakes], EbayError>)) -> Void)`
    private func getDataFromLocalDataBase(completion: @escaping((Result<[EarthQuake], EbayError>)) -> Void) {
        //Check if anything exist in local storage
        guard let data = dataManager.getData() else {
            completion(.failure(LocalErrors.notConnectedToInterNet))
            return
        }
        //If data exist then check if we should load data from database or we already loaded
        if paginator.shoulGetDataFromDataBase {
            paginator.didLoadDataBase(true)
            completion(.success(data))
        }
        completion(.failure(LocalErrors.notConnectedToInterNet))
    }
}

