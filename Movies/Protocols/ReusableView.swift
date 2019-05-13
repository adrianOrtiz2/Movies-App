//
//  ReusableView.swift
//  Movies
//
//  Created by Adrian Ortiz on 5/11/19.
//  Copyright © 2019 Adrian Ortiz. All rights reserved.
//

import UIKit

protocol ReusableView: AnyObject {}

extension ReusableView where Self: UIView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
