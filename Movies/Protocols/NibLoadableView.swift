//
//  NibLoadableView.swift
//  Movies
//
//  Created by Adrian Ortiz on 5/11/19.
//  Copyright © 2019 Adrian Ortiz. All rights reserved.
//

import UIKit

protocol NibLodableView: AnyObject {}

extension NibLodableView where Self: UIView {
    static var nibName: String {
        return String(describing: self)
    }
}
