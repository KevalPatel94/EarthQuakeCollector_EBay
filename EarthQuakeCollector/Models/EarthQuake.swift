//
//  EarthQuakes.swift
//  EarthQuakeCollector
//
//  Created by Keval Patel on 2/16/21.
//

import Foundation

// MARK: - EarthQuakes
struct EarthQuake: Codable, Equatable {
    
    public let earthQuakeProperties: EarthQuakeProperties
    
    enum CodingKeys: String, CodingKey {
        case earthQuakeProperties = "properties"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        earthQuakeProperties = try container.decode(EarthQuakeProperties.self, forKey: .earthQuakeProperties)
    }
    
    static func == (lhs: EarthQuake, rhs: EarthQuake) -> Bool {
        return lhs.earthQuakeProperties == rhs.earthQuakeProperties
    }
    
    /// For testing purpose only
    public init(earthQuakeProperties: EarthQuakeProperties) {
        self.earthQuakeProperties = earthQuakeProperties
    }
}


// MARK: - EarthQuakeProperties
struct EarthQuakeProperties: Codable, Equatable {
    public let magnitude: Double
    public let usgsUrl: String
    public let title: String
    public let status: String
    
    enum CodingKeys: String, CodingKey {
        case magnitude = "mag"
        case usgsUrl = "url"
        case title
        case status
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        magnitude = try container.decode(Double.self, forKey: .magnitude)
        usgsUrl = try container.decode(String.self, forKey: .usgsUrl)
        title = try container.decode(String.self, forKey: .title)
        status = try container.decode(String.self, forKey: .status)
    }
    
    /// For testing purpose only
    public init(magnitude: Double, usgsUrl: String, title: String, status: String) {
        self.magnitude = magnitude
        self.usgsUrl = usgsUrl
        self.title = title
        self.status = status
    }
}
