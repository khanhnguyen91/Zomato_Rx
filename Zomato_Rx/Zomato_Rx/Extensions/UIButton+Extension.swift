//
//  UIButton+Extension.swift
//  Zomato_Rx
//
//  Created by Nguyen Duc Huy on 6/13/20.
//  Copyright © 2020 nguyen.duc.huyb. All rights reserved.
//

extension UIButton {
    func setShadow() {
        layer.masksToBounds = false
        layer.shadowColor = R.color.shadowColor()?.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2.0)
        layer.shadowOpacity = 1.0
        layer.shadowRadius = 4.0

        // Ask iOS to cache the rendered shadow so that it doesn't need to be redrawn
        layer.shouldRasterize = true
        // iOS caches the shadow at the same drawing scale as the main screen
        layer.rasterizationScale = UIScreen.main.scale
    }
}
