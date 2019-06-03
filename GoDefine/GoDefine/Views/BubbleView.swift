//
//  BubbleView.swift
//  GoDefine
//
//  Created by Yang Qijun on 2/6/19.
//  Copyright © 2019 Yang Qijun. All rights reserved.
//

import UIKit
import Motion
import Material

class BubbleView: UIView {
    
    var assignHeightRatio: CGFloat!
    
    var containerView: UIView!
    var liquidView: UIView!
    var sufaceView: UIView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.shadowPath = UIBezierPath(ovalIn: self.bounds).cgPath
        self.layer.shadowRadius = 12
        self.layer.shadowOffset = .zero
        self.layer.shadowOpacity = 0.1
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        containerView = UIView(frame: rect)
        containerView.layer.masksToBounds = true
        containerView.layer.cornerRadius = frame.size.width * 0.5
        containerView.backgroundColor = UIColor(displayP3Red: 0/255.0, green: 255/255.0, blue: 205/255.0, alpha: 1.0)
        
        self.addSubview(containerView)
        let innerRect = CGRect(
            center: CGPoint(
                x: rect.midX,
                y: rect.midY),
            size: CGSize(
                width: rect.width*0.9,
                height: rect.height*0.9))
        
        let liquidContainer = createLiquidContainerView(innerRect)
        liquidView = createLiquidView(innerRect)
        sufaceView = createSufaceView(innerRect)
        liquidContainer.addSubview(liquidView)
        liquidContainer.addSubview(sufaceView)
        containerView.addSubview(liquidContainer)
        
        var counter: TimeInterval           = 0.0
        let period: TimeInterval            = 0.1
        let DeltaHeightRatio: CGFloat       = 0.05
        var sumDeltaHeightRatio: CGFloat    = 0.05
        var scaleRatio: CGFloat             = 1.0
        
        while sumDeltaHeightRatio < assignHeightRatio {
            scaleRatio = ((1.0 - sumDeltaHeightRatio)*sumDeltaHeightRatio).squareRoot() / 0.05
            
            liquidView.animate(
                .duration(period),
                .delay(counter*period),
                .translate(x: 0, y: -sumDeltaHeightRatio*innerRect.height),
                .timingFunction(.linear))
            
            sufaceView.animate(
                .duration(period),
                .delay(counter*period),
                .translate(x: 0, y: -sumDeltaHeightRatio*innerRect.height),
                .timingFunction(.linear),
                .scale(scaleRatio))
            
            sumDeltaHeightRatio += DeltaHeightRatio
            counter += 1
        }
        
    }
    
    func createLiquidContainerView(_ rect: CGRect) -> UIView {
        let liquidContainer = UIView(frame: rect)
        liquidContainer.clipsToBounds = true
        liquidContainer.layer.cornerRadius = rect.width*0.5
        
        return liquidContainer
    }
    
    func createLiquidView(_ rect: CGRect) -> UIView {
        let liquidRect = CGRect(
            center: CGPoint(
                x: rect.width/2,
                y: rect.height*1.5),  // temp
            size: CGSize(
                width: rect.height,
                height: rect.width))
        
        let liquidView = UIView(frame: liquidRect)
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = liquidView.bounds
        gradientLayer.colors = [
            UIColor(displayP3Red: 0/255.0, green: 221/255.0, blue: 5/255.0, alpha: 1).cgColor,
            UIColor(displayP3Red: 0/255.0, green: 182/255.0, blue: 0/255.0, alpha: 1).cgColor
        ]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        liquidView.layer.insertSublayer(gradientLayer, at: 0)
        
        return liquidView
    }
    
    func createSufaceView(_ rect: CGRect) -> UIView{
        let sufaceRect = CGRect(
            center: CGPoint(
                x: rect.width/2,
                y: rect.height),  // temp
            size: CGSize(
                width: rect.width*0.1,
                height: rect.width*0.02))
        
        let sufaceView = OvalView(frame: sufaceRect)
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = sufaceView.bounds
        gradientLayer.colors = [
            UIColor(displayP3Red: 0/255.0, green: 182/255.0, blue: 0/255.0, alpha: 1).cgColor,
            UIColor(displayP3Red: 0/255.0, green: 221/255.0, blue: 5/255.0, alpha: 1).cgColor
        ]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        sufaceView.layer.insertSublayer(gradientLayer, at: 0)
        
        return sufaceView
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
