//
//  MetaData.swift
//  EarthQuakeCollector
//
//  Created by Keval Patel on 2/16/21.
//

import Foundation

// MARK: - Event
struct MetaData: Codable {
    public let count: Int

    enum CodingKeys: String, CodingKey {
        case count
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        count = try container.decode(Int.self, forKey: .count)
    }

}
