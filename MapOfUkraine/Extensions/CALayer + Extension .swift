//
//  CALayer + Extension .swift
//  MapOfUkraine
//
//  Created by Volodymyr D on 21.02.2023.
//

import UIKit

extension CALayer {
    func addShape(withPath path: CGPath, shapeId: String, screenWidth: CGFloat, fillColor: CGColor? = nil, strokeColor: CGColor? = nil) {
        let sc = screenWidth / 680.9
        var scale = CGAffineTransform(scaleX: sc, y: sc) // 0.608 scale for iPhone11
        let trPath = path.copy(using: &scale)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = trPath
        shapeLayer.accessibilityLabel = shapeId
        shapeLayer.fillColor = fillColor
        shapeLayer.strokeColor = strokeColor
        shapeLayer.lineWidth = 0.3
        self.addSublayer(shapeLayer)
    }
}
