//
//  UICollectionView.swift
//  Movies
//
//  Created by Adrian Ortiz on 5/11/19.
//  Copyright © 2019 Adrian Ortiz. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    func register<T: UICollectionViewCell & NibLodableView & ReusableView>(_: T.Type) {
        let nib = UINib(nibName: T.nibName, bundle: nil)
        register(nib, forCellWithReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell & NibLodableView & ReusableView>(forIndexPath indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("")
        }
        return cell
    }
    
}
