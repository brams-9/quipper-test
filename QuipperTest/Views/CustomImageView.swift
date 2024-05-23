//
//  CustomImageView.swift
//  QuipperTest
//
//  Created by Rahman Bramantya on 23/05/24.
//

import UIKit

class CustomImageView: UIImageView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let cornerRadius: CGFloat = 20.0
        
        let path = UIBezierPath(roundedRect: self.bounds,
                                byRoundingCorners: [.bottomLeft, .bottomRight],
                                cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        
        self.layer.mask = maskLayer
    }
}
