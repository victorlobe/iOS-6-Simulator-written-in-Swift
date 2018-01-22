//
//  shimmerButtonViewController.swift
//  iOS 6
//
//  Created by Victor Lobe on 30.07.17.
//  Copyright © 2017 Victor Lobe. All rights reserved.
//

import UIKit

class ShimmerButton: UIButton {
    
    private let wrapperLayer = CALayer()
    private let gradientLayer = CAGradientLayer()
    
    var gradientColors: [UIColor] = [] {
        didSet {
            gradientLayer.colors = gradientColors.map({ $0.cgColor })
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // only needs to be set once, but no harm (?) in setting multiple times
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        wrapperLayer.addSublayer(gradientLayer)
        layer.insertSublayer(wrapperLayer, at: 0)
        wrapperLayer.mask = titleLabel?.layer
        
        // update sublayers based on new frame
        wrapperLayer.frame = frame
        gradientLayer.frame.size = CGSize(width: frame.width * 4, height: frame.height)
        
        // remove any existing animation, and re-create for new size
        let animationKeyPath = "position.x"
        
        gradientLayer.removeAnimation(forKey: animationKeyPath)
        
        let animation: CABasicAnimation = CABasicAnimation(keyPath: animationKeyPath)
        
        animation.fromValue = bounds.width - gradientLayer.bounds.width / 2
        animation.toValue = gradientLayer.bounds.width / 2
        animation.duration = 3
        
        animation.repeatCount = HUGE
        animation.fillMode = kCAFillModeForwards
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        gradientLayer.add(animation, forKey: animationKeyPath)
    }
}
