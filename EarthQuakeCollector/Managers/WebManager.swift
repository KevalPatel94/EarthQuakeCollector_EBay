//
//  EarthQuakeWebManager.swift
//  EarthQuakeCollector
//
//  Created by Keval Patel on 2/16/21.
//

import Foundation

//MARK:- EarthQuakeWebManager
/// `EarthQuakeWebManager`is a `singleton`, which will responsible for getting data from web server.
class EarthQuakeWebManager {
    static let shared = EarthQuakeWebManager()
    private init() {}
    
    /// `fetchEarthQuakeList` will get a list of Earthquake from web server using api call
    /// - Parameters:
    ///   - urlString: `String` of url
    ///   - expectingReturnType: epected Return Type
    ///   - completion: `@escaping((Result<T, EbayError>)) -> Void)`
    /// - Note: Here we can further create a subclass for the parth of `URLSession.shared.dataTask`, if we have multiple manager that makes different api calls
    func fetchEarthQuakeList<T: Codable>(urlString: String, expectingReturnType: T.Type, completion: @escaping((Result<T, EbayError>)) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(LocalErrors.inValidUrlType))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                completion(.failure(LocalErrors.serverError))
                return
            }
            do {
                guard let data = data else {
                    completion(.failure(LocalErrors.dataNotDecodable))
                    return
                }
                let decodableResult = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodableResult))
            }
            catch _ {
                completion(.failure(LocalErrors.noMoreDataAvailable))
            }
        }.resume()
    }
}
