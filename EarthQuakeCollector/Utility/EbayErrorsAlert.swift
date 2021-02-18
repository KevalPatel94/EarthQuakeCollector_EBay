//
//  EbayErrorAlert.swift
//  EarthQuakeCollector
//
//  Created by Keval Patel on 2/16/21.
//

import Foundation
import UIKit

// MARK: - EbayErrorAlert
struct EbayErrorAlert {
    var alert = UIAlertController()
    private let okButtonTitle = "OK"
    
    /// `showAlert` will present alert on parentViewController
    /// - Parameters:
    ///   - parentViewController: `UIViewController`
    ///   - error: `EbayError`
    mutating func showAlert(on parentViewController: UIViewController, error: EbayError) {
        guard !alert.isBeingPresented else { return }
        alert = UIAlertController(title: error.message, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: okButtonTitle, style: .default, handler: nil))
        parentViewController.present(alert, animated: true, completion: nil)
    }
}
