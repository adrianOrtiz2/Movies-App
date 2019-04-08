//
//  SkeletonView.swift
//  Movies
//
//  Created by Adrian Ortiz on 4/8/19.
//  Copyright © 2019 Adrian Ortiz. All rights reserved.
//

import Foundation
import UIKit

class SkeletonView: UIView, SkeletonAnimation {
    
    @IBInspectable var skeletonBackgroundColor: UIColor = UIColor(white: 0.85, alpha: 1.0)
    @IBInspectable var skeletonMovingColor: UIColor = UIColor(white: 0.75, alpha: 1.0)
    
    private var skeletonViews:[SkeletonAnimationHolder] = []
    private let startLocations: [NSNumber] = [-1.0, -0.5, 0.0]
    
    private func getGradientLayer(with bounds: CGRect) -> CAGradientLayer {
        let layer = CAGradientLayer()
        layer.frame = bounds
        layer.startPoint = CGPoint(x: 0.0, y: 1.0)
        layer.endPoint = CGPoint(x: 1.0, y: 1.0)
        layer.colors = [
            skeletonBackgroundColor.cgColor,
            skeletonMovingColor.cgColor
        ]
        layer.locations = startLocations
        return layer
    }
    
    private func createSkeleton(with view: UIView, parent: UIView) {
        let skeleton = UIView(frame: view.frame)
        let animationLayer = getGradientLayer(with: skeleton.bounds)
        skeleton.layer.addSublayer(animationLayer)
        skeleton.isHidden = true
        skeletonViews.append(SkeletonAnimationHolder(view: skeleton, layerAnimation: animationLayer))
        parent.addSubview(skeleton)
    }
    
    private func iterateSubviews(subviews: [UIView], parent: UIView) {
        for view in subviews {
            if view is UIStackView {
                iterateSubviews(subviews: (view as! UIStackView).subviews, parent: view)
            } else {
                createSkeleton(with: view, parent: parent)
            }
        }
    }
    
    func startAnimating() {
        for v in skeletonViews {
            self.startAnimation(with: v.layerAnimation)
        }
    }
    
    func stopAnimating() {
        for v in skeletonViews {
            self.stopAnimation(with: v.layerAnimation)
            v.view.removeFromSuperview()
        }
    }
    
    override func draw(_ rect: CGRect) {
        iterateSubviews(subviews: self.subviews, parent: self)
    }
}
