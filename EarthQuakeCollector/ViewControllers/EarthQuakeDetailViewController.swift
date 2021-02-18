//
//  EarthQuakeDetailViewController.swift
//  EarthQuakeCollector
//
//  Created by Keval Patel on 2/16/21.
//

import Foundation

import UIKit
import WebKit

/// `EarthQuakeDetailModel` for `EarthQuakeDetailViewController`
struct EarthQuakeDetailModel: Equatable {
    let usgsUrlUrlString: String
}

class EarthQuakeDetailViewController: UIViewController {
    @IBOutlet weak var wkWebView: WKWebView!
    private lazy var viewModel: WebViewModel = {
        return WebViewModel()
    }()
    var earthQuakeDetailModel: EarthQuakeDetailModel? = nil
    var alert = EbayErrorAlert()
    override func viewDidLoad() {
        super.viewDidLoad()
        wkWebView.navigationDelegate = self
        configureNavigationBar()
        loadWebView(urlString: earthQuakeDetailModel?.usgsUrlUrlString)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        wkWebView.stopLoading()
    }
}

//MARK:- Configure UINavigationBar
extension EarthQuakeDetailViewController: WebViewProvider {
    /// `loadWebView ` configure and load webview
    /// - Parameter urlString: `String?``
    internal func loadWebView(urlString: String?) {
        guard let url = urlString, let request = viewModel.getReuest(urlString: url) else { return }
        showErrorAlert(ebayError: viewModel.isConnectedToInternet())
        wkWebView.load(request)
    }
    
    /// `configureNavigationBar` manages configuration of `UINavigationBar`
    internal func configureNavigationBar() {
        self.navigationItem.title = viewModel.naviogationTitle
        createNavigationBarButton()
    }
    
    /// `createNavigationBarButton` creates `UIBarButtonItem`
    private func createNavigationBarButton() {
        let rightBarButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshButtonClickAction))
        self.navigationItem.rightBarButtonItem = rightBarButton
        WebAccessibility().addAccessibility(barButtonItem: rightBarButton)
    }
    
    /// `refreshButtonClickAction` used as action event for barbutton click
    @objc private func refreshButtonClickAction() {
        showErrorAlert(ebayError: viewModel.isConnectedToInternet())
        // We can do Url caching here and reload the last URl that failed to load
        loadWebView(urlString: earthQuakeDetailModel?.usgsUrlUrlString)
    }
}


//MARK: - WKNavigationDelegate
extension EarthQuakeDetailViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        alert.showAlert(on: self, error: viewModel.canNotLoadPageError)
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        alert.showAlert(on: self, error: viewModel.canNotLoadPageError)
    }
    
    /// showErrorAlert will construct and display erroe alert based on EbayError passed into it.
    /// - Parameters:
    ///     - EbayError: EbayError?
    /// showErrorAlert will construct and display erroe alert based on EbayError passed into it.
    /// - Parameters:
    ///     - EbayError: EbayError?
    func showErrorAlert(ebayError: EbayError?)  {
        guard let ebayError = ebayError else { return }
        alert.showAlert(on: self, error: ebayError)
    }
}
