//
//  BubbleView.swift
//  GoDefine
//
//  Created by Yang Qijun on 2/6/19.
//  Copyright © 2019 Yang Qijun. All rights reserved.
//

import UIKit

class BubbleView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.clipsToBounds = true
        self.layer.cornerRadius = frame.size.width * 0.5
        self.backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        var waterLevelRect = rect
        waterLevelRect.origin.y = rect.origin.y + rect.size.height * 0.5
        let waterLevel = UIView(frame: waterLevelRect)
        waterLevel.backgroundColor = UIColor.blue
        self.addSubview(waterLevel)
        
        var waterSufaceRect = rect
        waterSufaceRect.size.height = waterSufaceRect.size.width * 0.2
        waterSufaceRect.origin.y = rect.origin.y + rect.size.height * 0.5 - waterSufaceRect.size.height * 0.5
        let waterSuface = OvalView(frame: waterSufaceRect)
        waterSuface.backgroundColor = UIColor.red
        self.addSubview(waterSuface)
    }
    
}

class OvalView: UIView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutOvalMask()
    }
    
    private func layoutOvalMask() {
        let mask = self.shapeMaskLayer()
        let bounds = self.bounds
        if mask.frame != bounds {
            mask.frame = bounds
            mask.path = CGPath(ellipseIn: bounds, transform: nil)
        }
    }
    
    private func shapeMaskLayer() -> CAShapeLayer {
        if let layer = self.layer.mask as? CAShapeLayer {
            return layer
        }
        let layer = CAShapeLayer()
        layer.fillColor = UIColor.black.cgColor
        self.layer.mask = layer
        return layer
    }
    
}
