//
//  EarthQuakeListViewController.swift
//  EarthQuakeCollector
//
//  Created by Keval Patel on 2/16/21.
//

import Foundation

import UIKit


class EarthQuakeListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
    var alert = EbayErrorAlert()
    private lazy var viewModel: EarthQuakeViewModel = {
        return EarthQuakeViewModel(earthQuakeManagementProvider: EarthQuakeManager.shared)
    }()
    /// We need this to hold on to dataSource since collectionview has weak reference to its datasource.
    private var dataSource: UITableViewDataSource?
    private var isLastPage: Bool = false
    private var isPresentingAlert: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        generateEarthQuakeDataSource()
        configureActivityIndicator()
        reloadTableViewWithNewData(earthQuakeDataSource: nil)
        configureNavigationBar()
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.tableFooterView = UIView()
    }
    
    private func configureActivityIndicator() {
        activityIndicator.color = EbayColors.primaryColor
        activityIndicator.center = self.view.center
        self.view.addSubview(activityIndicator)
        startAnimation()
    }
}

//MARK:- Configure UINavigationbar
extension EarthQuakeListViewController {
    /// `configureNavigationBar` manages configuration of `UINavigationBar`
    private func configureNavigationBar() {
        self.navigationItem.title = Constants.navigationBarTitleEarthQuake
        createNavigationBarButton()
    }
    
    /// `createNavigationBarButton` creates `UIBarButtonItem`
    private func createNavigationBarButton() {
        let rightBarButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshButtonClickAction))
        self.navigationItem.rightBarButtonItem = rightBarButton
        addAccessibility(barButtonItem: rightBarButton)
    }
}

//MARK:- ADA Method
extension EarthQuakeListViewController {
    /// `addAccessibility` is used to add accessibilit of `UIBarButtonItem`
    /// - Parameter barButtonI tem: `UIBarButtonItem`
    private func addAccessibility(barButtonItem: UIBarButtonItem) {
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
//MARK: - Fetch Data
extension EarthQuakeListViewController {
    /// `refreshButtonClickAction` used as action event for barbutton click
    @objc private func refreshButtonClickAction() {
        generateEarthQuakeDataSource()
    }
    
    /// `generateEarthQuakeDataSource()` gets data from `EarthQuakeViewModel`
    private func generateEarthQuakeDataSource() {
        startAnimation()
        viewModel.fetchEarthQuake { [weak self] (result) in
            switch result {
            case .success(let earthQuakes):
                guard let tableView = self?.tableView else { return }
                DispatchQueue.main.async {
                    let dataSource = EarthQuakesDataSource(items: earthQuakes, tableView: tableView)
                    self?.stopAnimation()
                    self?.reloadTableViewWithNewData(earthQuakeDataSource: dataSource)
                }
            case .failure(let ebayError):
                DispatchQueue.main.async {
                    self?.stopAnimation()
                    self?.showErrorAlert(ebayError: ebayError)
                }
            }
        }
    }
    
    /// `reloadTableViewWithNewData` reloads tableviewwith `EarthQuakesDataSource`
    /// - Parameter earthQuakeDataSource: `EarthQuakesDataSource?`
    private func reloadTableViewWithNewData(earthQuakeDataSource: EarthQuakesDataSource?) {
        guard let earthQuakeDataSource = earthQuakeDataSource else { return }
        dataSource = earthQuakeDataSource
        tableView.dataSource = earthQuakeDataSource
        tableView.reloadData()
        activityIndicator.stopAnimating()
    }
}

// MARK: - TableView Delegate
extension EarthQuakeListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let reloadIndex: Int = viewModel.listOfEarthQuakes.count - 5
        if indexPath.row == viewModel.listOfEarthQuakes.count { startAnimation() }
        if indexPath.row == reloadIndex {
            //Make an api call
            generateEarthQuakeDataSource()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigateToDetailViewController(with: viewModel.listOfEarthQuakes[indexPath.row].earthQuakeProperties)
    }
    
    /// `navigateToDetailViewController` navigates to `EarthQuakeDetailViewController`
    /// - Parameter earthQuakeProperties: `EarthQuakeProperties``
    private func navigateToDetailViewController(with earthQuakeProperties: EarthQuakeProperties) {
        let storyboard = UIStoryboard(name: Constants.main, bundle: nil)
        if #available(iOS 13.0, *) {
            if let earthQuakeDetailVC = storyboard.instantiateViewController(withIdentifier: Constants.earthQuakeDetailViewController) as? EarthQuakeDetailViewController {
                earthQuakeDetailVC.earthQuakeDetailModel = viewModel.generateEarthQuakeDetailModel(earthquake: earthQuakeProperties)
                self.navigationController?.pushViewController(earthQuakeDetailVC, animated: true)
            }
        }
        else {
            if let deprecatedDetailVC = storyboard.instantiateViewController(withIdentifier: Constants.deprecatedDetailViewController) as? DeprecatedDetailViewController {
                deprecatedDetailVC.earthQuakeDetailModel = viewModel.generateEarthQuakeDetailModel(earthquake: earthQuakeProperties)
                self.navigationController?.pushViewController(deprecatedDetailVC, animated: true)
            }
        }
    }
}

// MARK: - ErrorAlertView
extension EarthQuakeListViewController {
    /// showErrorAlert will construct and display erroe alert based on EbayError passed into it.
    /// - Parameters:
    ///     - EbayError: SchedulerError?
    private func showErrorAlert(ebayError: EbayError?)  {
        guard let ebayError = ebayError else { return }
        if ebayError.kind == EbayError.ErrorKind.noMoreDataAvailable { isLastPage = true }
        alert.showAlert(on: self, error: ebayError)
    }
    
    /// `startAnimation` disable user interaction with table view and start animation of activityIndicator
    private func startAnimation() {
        tableView.disable()
        guard !isLastPage else { return }
        activityIndicator.startAnimating()
    }
    
    /// `stopAnimation` enables user interaction with table view and stop animation of activityIndicator
    private func stopAnimation() {
        tableView.enable()
        tableView.alpha = 1.0
        activityIndicator.stopAnimating()
    }
    
    
}

// MARK: - Constants
///- Note: usually Localization part comes here
extension EarthQuakeListViewController {
    struct Constants {
        static let earthQuakeDetailViewController = "EarthQuakeDetailViewController"
        static let main = "Main"
        static let navigationBarTitleEarthQuake = "Earthquakes"
        static let deprecatedDetailViewController = "DeprecatedDetailViewController"
    }
}


