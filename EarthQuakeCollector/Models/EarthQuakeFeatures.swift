//
//  EarthQuakeFeatures.swift
//  EarthQuakeCollector
//
//  Created by Keval Patel on 2/16/21.
//

import Foundation

import Foundation

// MARK: - EarthQuakeFeatures
/// - Note: Encodable and Decodable is `Memento Design Pattern`
struct EarthQuakeFeatures: Codable {
    public let earthQuakes: [EarthQuake]
    public let metaData: MetaData
    
    enum CodingKeys: String, CodingKey {
        case earthQuakes = "features"
        case metaData = "metadata"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        earthQuakes = try container.decode([EarthQuake].self, forKey: .earthQuakes)
        metaData = try container.decode(MetaData.self, forKey: .metaData)
    }
}
