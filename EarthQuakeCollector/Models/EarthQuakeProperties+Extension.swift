//
//  EarthQuakeProperties+Extension.swift
//  EarthQuakeCollector
//
//  Created by Keval Patel on 2/16/21.
//

import Foundation


extension EarthQuakeProperties {
    
    /// EarthQuake magnitudeDescription to display
    private var magnitudeDescription: String {
        return "Magnitude: \(magnitude)"
    }
    
    /// EarthQuake detail Description to display
    var eventDetailDescription: String {
        return "\(magnitudeDescription)"
    }
    
    /// EarthQuake status detail Description to display
    var statusDetailDescription: String {
        return "Status: \(status)"
    }
    
    /// EarthQuake status profileLetter to display
    var profileLetter: String {
        guard let letter = title.last else { return "E" }
        return "\(letter)".uppercased()
    }
}
