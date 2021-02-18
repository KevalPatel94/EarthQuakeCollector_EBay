//
//  EarthQuakesDataSource.swift
//  EarthQuakeCollector
//
//  Created by Keval Patel on 2/16/21.
//

import Foundation
import UIKit

/// `EarthQuakesDataSource` is subclass of `UITableViewDataSource`. which created data souce for model type `[EarthQuakes]`
class EarthQuakesDataSource: NSObject, UITableViewDataSource {
    private let models: [EarthQuake]
    init(items: [EarthQuake]?, tableView: UITableView) {
        tableView.registerCellNib(for: EarthQuakeCell.self)
        self.models = items ?? []
        super.init()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeCell(for: EarthQuakeCell.self, at: indexPath)
        cell.earthQuakeCellModel = models[indexPath.row].earthQuakeProperties
        return cell
    }
    
}
