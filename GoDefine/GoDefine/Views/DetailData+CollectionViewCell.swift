//
//  DetailData+CollectionViewCell.swift
//  GoDefine
//
//  Created by Yang Qijun on 30/5/19.
//  Copyright © 2019 Yang Qijun. All rights reserved.
//

import UIKit

class DetailData_CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var goalLabel: UILabel!
    override func draw(_ rect: CGRect) {
        var bgRect = rect
        bgRect.origin.y += 20
        bgRect.size.height -= 20
        let bgColor = UIColor(displayP3Red: 181/255, green: 0, blue: 1, alpha: 1)
        let bg = UIBezierPath(roundedRect: bgRect, cornerRadius: 10.0)
        bgColor.setFill()
        bg.fill()
        
        let stateSymbolRect = CGRect(x: rect.origin.x+rect.size.width*0.6, y: rect.origin.y, width: 50, height: 50)
//        let stateSymbol = UIBezierPath(ovalIn: stateSymbolRect)
//        stateSymbol.fill()
        let stateSymbolView = UIView(frame: stateSymbolRect)
        stateSymbolView.backgroundColor     = bgColor
        stateSymbolView.clipsToBounds       = true
        stateSymbolView.layer.cornerRadius  = stateSymbolRect.size.width/2
        
        let stateSymbolImageRect = CGRect(x: 3, y: 3, width: 44.0, height: 44.0)
        let stateSymbolImageView = UIImageView(frame: stateSymbolImageRect)
        stateSymbolImageView.image = UIImage(named: "checked_icon")
        stateSymbolView.addSubview(stateSymbolImageView)
        self.addSubview(stateSymbolView)
        
        let goalBgRect = CGRect(x: rect.origin.x+3, y: rect.origin.y+rect.size.height-47.0, width: bgRect.size.width*0.65, height: 44.0)
        let goalBgColor = UIColor(displayP3Red: 244/255, green: 217/255, blue: 1, alpha: 1)
        let goalBg = UIBezierPath(roundedRect: goalBgRect, cornerRadius: 8.0)
        goalBgColor.setFill()
        goalBg.fill()
    }
    
}
