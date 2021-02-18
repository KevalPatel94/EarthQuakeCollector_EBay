//
//  Date+Extension.swift
//  EarthQuakeCollector
//
//  Created by Keval Patel on 2/16/21.
//

import Foundation

enum EbayDateFormat: String {
    case yyyymmdd = "yyyy-MM-dd"
    case mmddyyyy = "MM-dd-yyyy"
}

extension Date {
    
    var todayDateString: String {
        return today(dateFormat: EbayDateFormat.yyyymmdd)
    }
    
    var lastDateString: String {
        return previousDate(dateFormat: EbayDateFormat.yyyymmdd)
    }
    
    /// return date in string format..
    /// - Parameters:
    ///     - dateFormat: EbayDateFormat
    /// - Returns: String
    func convertToString(dateFormat: EbayDateFormat) -> String {
        let dateFormatter: DateFormatter = constructDateFormatter(format: dateFormat.rawValue)
        return dateFormatter.string(from: self)
    }
    
    /// return today's date in string format..
    /// - Parameters:
    ///     - dateFormat: EbayDateFormat
    /// - Returns: String
    private func today(dateFormat: EbayDateFormat) -> String {
        let dateFormatter: DateFormatter = constructDateFormatter(format: dateFormat.rawValue)
        return dateFormatter.string(from: Date())
    }
    
    /// return the date after 30 days from today.
    /// - Parameters:
    ///     - dateFormat: EbayDateFormat
    /// - Returns: String
    private func previousDate(dateFormat: EbayDateFormat) -> String {
        guard let lastDate = Calendar.current.date(byAdding: .day, value: -30, to: Date()) else { return "" }
        let dateFormatter: DateFormatter = constructDateFormatter(format: dateFormat.rawValue)
        return dateFormatter.string(from: lastDate)
    }
    
    /// constructDateFormatter construct the DateFormatter with any dateFormat given as an input.
    /// - Parameters:
    ///     - dateFormat: String
    /// - Returns: DateFormatter
    private func constructDateFormatter(format: String) -> DateFormatter {
        let localIdentifier = "en_US_POSIX"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier: localIdentifier)
        return dateFormatter
    }
}
