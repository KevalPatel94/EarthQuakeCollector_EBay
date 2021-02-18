//
//  DeprecatedDetailViewController.swift
//  EarthQuakeCollector
//
//  Created by Keval Patel on 2/17/21.
//

import UIKit
import WebKit

class DeprecatedDetailViewController: UIViewController {
    @IBOutlet weak var webView: UIWebView!
    var alert = EbayErrorAlert()
    private lazy var viewModel: WebViewModel = {
        return WebViewModel()
    }()
    var earthQuakeDetailModel: EarthQuakeDetailModel? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        webView.delegate = self
        configureNavigationBar()
        loadWebView(urlString: earthQuakeDetailModel?.usgsUrlUrlString)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        webView.stopLoading()
    }
}

//MARK: - DeprecatedDetailViewController
extension DeprecatedDetailViewController: UIWebViewDelegate {
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        alert.showAlert(on: self, error: viewModel.canNotLoadPageError)
    }
}

extension DeprecatedDetailViewController: WebViewProvider {
    /// `loadWebView ` configure and load webview
    /// - Parameter urlString: `String?``
    internal func loadWebView(urlString: String?) {
        guard let url = urlString, let request = viewModel.getReuest(urlString: url) else { return }
        showErrorAlert(ebayError: viewModel.isConnectedToInternet())
        webView.loadRequest(request)
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
