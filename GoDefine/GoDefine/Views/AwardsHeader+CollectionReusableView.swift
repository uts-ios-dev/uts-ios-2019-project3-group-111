//
//  AwardsHeader+CollectionReusableView.swift
//  GoDefine
//
//  Created by Yang Qijun on 29/5/19.
//  Copyright © 2019 Yang Qijun. All rights reserved.
//

import UIKit

class AwardsHeader_CollectionReusableView: UICollectionReusableView {
    
    var awardType: AwardType?
    
    @IBOutlet weak var awardTypeLabel: UILabel!
    
    override func draw(_ rect: CGRect) {
        awardTypeLabel.text = awardType?.name
        awardTypeLabel.textColor = awardType?.color
        
        let drawRect = CGRect(x: (rect.origin.x+12), y: (rect.size.height/2-15+rect.origin.y), width: 5, height: 30)
        let path = UIBezierPath(rect: drawRect)
        
        path.move(to: CGPoint(x: (rect.origin.x+12), y: (rect.size.height+rect.origin.y)))
        path.addLine(to: CGPoint(x: (rect.size.width-rect.origin.x), y: (rect.size.height+rect.origin.y)))
        
        awardType?.color.setFill()
        path.fill()
        
        awardType?.color.setStroke()
        path.stroke()
        
    }
}
