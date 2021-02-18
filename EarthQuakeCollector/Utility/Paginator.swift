//
//  Paginator.swift
//  EarthQuakeCollector
//
//  Created by Keval Patel on 2/16/21.
//

import Foundation

//MARK:- Paginator
/// `Paginator` manages pagination part of api call  to keep track of which page we are on.
class Paginator {
    private var offset: Int
    private var count: Int
    private var _isLastPage: Bool = false
    private var _isDataBaseAlreadyLoaded: Bool = false
    private let _limit = GlobalConstants.limit
    init(offset:Int, count:Int) {
        self.offset = offset
        self.count = count
    }
    
    func updatePage(newCount: Int) {
        offset += newCount
        count = newCount
        if newCount < _limit {
            _isLastPage = true
        }
    }
    
    func didLoadDataBase(_ isLoaded: Bool) {
        _isDataBaseAlreadyLoaded = isLoaded
    }
}

//MARK:- extension
extension Paginator {
    
    /// `nextOffSet` holds value of start index from which we need to get data from.
    var nextOffSet: String {
        return "\(offset)"
    }
    
    var isLastPage: Bool {
        return _isLastPage
    }
    
    var isFirstPage: Bool {
        return offset == 1
    }
    
    /// `shoulGetDataFromDataBase` keepd track wether we arleady loaded data from database or not.
    var shoulGetDataFromDataBase: Bool {
        return isFirstPage && !_isDataBaseAlreadyLoaded
    }
}
