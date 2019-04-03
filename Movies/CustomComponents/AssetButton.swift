//
//  AssetButton.swift
//  Movies
//
//  Created by Adrian Ortiz on 3/26/19.
//  Copyright © 2019 Adrian Ortiz. All rights reserved.
//

import UIKit

class AssetButton: UIButton {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if let icon = imageView {
            imageEdgeInsets = UIEdgeInsets(top: 5, left: bounds.width - 35, bottom: 5, right: 5)
            titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: icon.frame.width)
        }
        self.layer.cornerRadius = 10
    }
    
}
