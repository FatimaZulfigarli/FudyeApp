//
//  CuisineViewModel.swift
//  FudyeApp
//
//  Created by Fatya on 29.06.24.
//

import Foundation

class CuisineViewModel {
    var cuisine: [Menu] = []
    let menuManagerHelper = MenuManagerHelper()
    var reloadCollectionView: (() -> Void)?
    
    init() {
        menuManagerHelper.callback = { [weak self] in
            guard let self = self else { return }
            self.cuisine = menu
            self.reloadCollectionView?()
        }
    }
    
    func fetchCuisine() {
        menuManagerHelper.parseMenu()
    }
    
    func numberOfItems() -> Int {
        return cuisine.count
    }
    
    func item(at index: Int) -> Menu {
        return cuisine[index]
    }
}
