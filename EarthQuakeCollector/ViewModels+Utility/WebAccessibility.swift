//
//  UIViewController+Extension.swift
//  EarthQuakeCollector
//
//  Created by Keval Patel on 2/17/21.
//

import Foundation
import UIKit

class WebAccessibility {
    init () {}
    /// `addAccessibility` is used to add accessibilit of `UIBarButtonItem`
    /// - Parameter barButtonI tem: `UIBarButtonItem`
    func addAccessibility(barButtonItem: UIBarButtonItem) {
        enum Elements: String {
            case refresh
            case refreshBarButton
            case willRefreshData = "It will Refresh Data"
        }
        barButtonItem.addAccessibility(accessibilityproperties: AccessibilityProperties(accessibilityLabel: Elements.refresh.rawValue,
                                                                                        accessibilityIdentifier: Elements.refreshBarButton.rawValue,
                                                                                        accessibilityHint: Elements.willRefreshData.rawValue))
    }
}
