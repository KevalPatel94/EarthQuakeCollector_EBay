//
//  UITableView+Extension.swift
//  EarthQuakeCollector
//
//  Created by Keval Patel on 2/16/21.
//

import Foundation
import UIKit

//MARK: - Registrable
/// `Registrable` is used to get  `reuseIdentifier` from `UITableViewCell` subclass
public protocol Registrable {
    static var reuseIdentifier: String { get }
}

extension Registrable {
    public static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: Registrable {}

//MARK:- ResgiterCell and dequeueReusableCell
extension UITableView {
    /// `registerCellNib`  registers  `UITableViewCell`
    /// - Parameter registrable: `T.Type`
    public func registerCellNib<T: UITableViewCell>(for registrable: T.Type) {
        register(UINib.init(nibName: T.reuseIdentifier, bundle: nil),
                 forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    /// `dequeCell`  generate and return `dequeueReusableCell` genric.
    /// - Parameter registrable: `T.Type`
    /// - Parameter indexPath: `IndexPath``
    /// - Returns: `T``
    public func dequeCell<T: UITableViewCell>(for registrable: T.Type, at indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }
}

//MARK: - Enable and Disable TableView
extension UITableView {
    
    /// Disables userIteraction of TableView
    func disable() {
        alpha = 0.3
        isUserInteractionEnabled = false
    }
    
    /// Enable  userIteraction of TableView
    func enable() {
        alpha = 1.0
        isUserInteractionEnabled = true
    }
    
}
