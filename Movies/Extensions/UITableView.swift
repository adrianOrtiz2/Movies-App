//
//  UITableView.swift
//  Movies
//
//  Created by Adrian Ortiz on 5/11/19.
//  Copyright © 2019 Adrian Ortiz. All rights reserved.
//

import UIKit

extension UITableView {
    
    func register<T: UITableViewCell & NibLodableView & ReusableView>(_: T.Type) {
        let nib = UINib(nibName: T.nibName, bundle: nil)
        register(nib, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell & NibLodableView & ReusableView>(forIndexPath indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("")
        }
        return cell
    }
    
}
