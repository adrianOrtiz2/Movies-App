//
//  SkeletonAnimation.swift
//  Movies
//
//  Created by Adrian Ortiz on 4/8/19.
//  Copyright © 2019 Adrian Ortiz. All rights reserved.
//

import Foundation
import UIKit

protocol SkeletonAnimation {
    func startAnimation(with layer: CAGradientLayer)
    func stopAnimation(with layer: CAGradientLayer)
}

extension SkeletonAnimation where Self: UIView {
    
    func startAnimation(with layer: CAGradientLayer) {
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [-1.0, -0.5, 0.0]
        animation.toValue = [1.0, 1.5, 2.0]
        animation.duration = 0.8
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        
        let animatonGroup = CAAnimationGroup()
        animatonGroup.duration = 1.8
        animatonGroup.animations = [animation]
        animatonGroup.repeatCount = .infinity
        layer.add(animatonGroup, forKey: animation.keyPath)        
    }
    
    func stopAnimation(with layer: CAGradientLayer) {
        layer.removeAllAnimations()
    }
}
