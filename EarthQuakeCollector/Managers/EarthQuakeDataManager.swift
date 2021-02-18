//
//  EarthQuakeDataManager.swift
//  EarthQuakeCollector
//
//  Created by Keval Patel on 2/16/21.
//

import Foundation

//MARK:- GlobalConstants
/// - Note: It saves the constants
struct GlobalConstants {
    /// `limit` is used to set limit for number of entries in each api call.
    static let limit: Int = 30
}

//MARK:- EarthQuakeManager
/// `EarthQuakeManagementProvider`is a `singleton`, which will responsible for reading and writting data to local storage.
class EarthQuakeDataManager {
    private let earthQuakeKey = "EarthQuakeKey"
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    static let shared = EarthQuakeDataManager()
    var userDefault = UserDefaults.standard
    private init() {}
    
    /// `saveData` will save data to local storage
    /// - Parameters:
    ///   - earthQuakes: `[EarthQuakes]` that needs to be saved
    ///   - isFirstPage: `Bool` which says, whether it is the firstPage of api call
    /// - Note: This function taking `Bool` in argument which is not a ideal way but here we dont have any choice other than passing `Bool`or `Paginator`
    func saveData(earthQuakes: [EarthQuake], isFirstPage: Bool) {
        if isFirstPage {
            saveAllData(earthQuakes: earthQuakes)
        }
        else {
            appendDataToStorage(earthQuakes: earthQuakes)
        }
    }
    
    /// `appendDataToStorage` will append data to storage
    /// - Parameter earthQuakes: `[EarthQuakes]` that needs to be appended
    private func appendDataToStorage(earthQuakes: [EarthQuake]) {
        guard var earthQuakeArray = getData() else { return }
        earthQuakeArray.append(contentsOf: earthQuakes)
        saveAllData(earthQuakes: earthQuakeArray)
    }
    
    /// `appendDataToStorage` will save all data to storage
    /// - Parameter earthQuakes: `[EarthQuakes]` that needs to be saved
    private func saveAllData(earthQuakes: [EarthQuake]) {
        if let encoded = try? encoder.encode(earthQuakes) {
            userDefault.setValue(encoded, forKey: earthQuakeKey)
        }
    }
    
    
    /// `getData()` will get data from storage
    /// - Returns: [EarthQuakes]?
    func getData() -> [EarthQuake]? {
        if let savedData = userDefault.object(forKey: earthQuakeKey) as? Data {
            if let earthQuakes = try? decoder.decode([EarthQuake].self, from: savedData) {
                return earthQuakes
            }
        }
        return nil
    }
}
