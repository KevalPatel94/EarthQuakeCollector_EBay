//
//  WebViewModel.swift
//  EarthQuakeCollector
//
//  Created by Keval Patel on 2/17/21.
//

import Foundation
import UIKit

//MARK: - WebViewProvider
protocol WebViewProvider {
    func loadWebView(urlString: String?)
    func showErrorAlert(ebayError: EbayError?)
    func configureNavigationBar()
}

//MARK: - WebViewModel
class WebViewModel {
    let naviogationTitle: String = Constants.navigationBarTitle
    let canNotLoadPageError: EbayError = LocalErrors.canNotLoadWebView
    let notConnectedToInternetError: EbayError = LocalErrors.notConnectedToInterNet
    
    init() {}
    
    /// `getReuest` generate URLRequest
    /// - Parameter urlString: `String?`
    /// - Returns: `URLRequest?`
    func getReuest(urlString: String?) -> URLRequest? {
        guard let urlString = urlString else { return  nil }
        guard let url = URL(string: urlString) else { return nil }
        return URLRequest(url: url)
    }
    
    /// `isConnectedToInternetcheck` If connected to internet.
    /// - Returns: `EbayError?`
    func isConnectedToInternet() -> EbayError? {
        guard !Internet.isConnected() else { return nil }
        return notConnectedToInternetError
    }
    
    
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

//MARK: - Constants
extension WebViewModel {
    struct Constants {
        static let navigationBarTitle = "USGS Web"
    }
}

