//
//  CGColor + Extension.swift
//  MapOfUkraine
//
//  Created by Volodymyr D on 21.02.2023.
//

import CoreGraphics
 
extension CGColor {
    static func blueSelectColorWithAlpha() -> CGColor { .init(red: 0.1, green: 0, blue: 1, alpha: 0.3) }
    static func zeroAlpha() -> CGColor { .init(red: 0, green: 0, blue: 0, alpha: 0) }
    
}
