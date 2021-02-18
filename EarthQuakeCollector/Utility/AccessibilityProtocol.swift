//
//  AccessibilityProtocol.swift
//  EarthQuakeCollector
//
//  Created by Keval Patel on 2/16/21.
//

import Foundation
import UIKit

//MARK:- AccessibilityProtocol
/// `AccessibilityProtocol` is used to provide abstraction of `addAccessibility`
protocol AccessibilityProtocol {
    /// `addAccessibility` is used to add accessibility
    /// - Parameter accessibilityproperties: `AccessibilityProperties`
    func addAccessibility(accessibilityproperties: AccessibilityProperties)
}
 
// We can configure any number of parameter as we need.
//MARK:- AccessibilityProperties
/// `AccessibilityProperties` is the struct which includes different accessibility preperties
struct AccessibilityProperties {
    let accessibilityLabel: String
    let accessibilityIdentifier: String?
    let accessibilityHint: String?
    init(accessibilityLabel: String, accessibilityIdentifier: String? = nil, accessibilityHint: String? = nil) {
        self.accessibilityLabel = accessibilityLabel
        self.accessibilityIdentifier = accessibilityIdentifier
        self.accessibilityHint = accessibilityHint
    }
}

//MARK:- UILabel Accessibility
extension UILabel: AccessibilityProtocol {
    func addAccessibility(accessibilityproperties: AccessibilityProperties) {
        self.accessibilityLabel = accessibilityproperties.accessibilityLabel + "Label"
        if let identifier = accessibilityproperties.accessibilityIdentifier {
            self.accessibilityIdentifier = identifier
        }
    }
}

//MARK:- UIBarButtonItem Accessibility
extension UIBarButtonItem: AccessibilityProtocol {
    func addAccessibility(accessibilityproperties: AccessibilityProperties) {
        self.accessibilityLabel = accessibilityproperties.accessibilityLabel + "BarButton"
        if let identifier = accessibilityproperties.accessibilityIdentifier {
            self.accessibilityIdentifier = identifier
        }
        if let hint = accessibilityproperties.accessibilityHint {
            self.accessibilityHint = hint
        }
    }
}

//MARK:- UINavigationItem Accessibility
extension UINavigationItem: AccessibilityProtocol {
    func addAccessibility(accessibilityproperties: AccessibilityProperties) {
        self.accessibilityLabel = accessibilityproperties.accessibilityLabel + "NavigationItem"
    }
}

///We can use the same protocol for all UIElement for example as below. Below properties are not used any where. Those are just for an example.
//MARK:- UIButton Accessibility
extension UIButton: AccessibilityProtocol {
    func addAccessibility(accessibilityproperties: AccessibilityProperties) {
        self.accessibilityLabel = accessibilityproperties.accessibilityLabel + "Button"
        self.accessibilityIdentifier = accessibilityproperties.accessibilityIdentifier
    }
}
