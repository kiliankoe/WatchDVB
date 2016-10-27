//
//  UIImage+Text.swift
//  WatchDVB
//
//  Created by Kilian Költzsch on 23/05/16.
//  Copyright © 2016 Kilian Koeltzsch. All rights reserved.
//

import UIKit

extension UIImage {
    static func imageWithText(_ text: String, size: Double) -> UIImage {

        let image = UIImage()

        UIGraphicsBeginImageContext(CGSize(width: size, height: size))

        let ctx = UIGraphicsGetCurrentContext()!
        UIGraphicsPushContext(ctx)

        var rect = CGRect(x: 0, y: 0, width: size, height: size)

        image.draw(in: rect)

        UIColor.red.set()
        ctx.fillEllipse(in: rect)

        let textColor: UIColor = UIColor.white
        let textFont: UIFont = UIFont(name: "Helvetica Bold", size: 12)!

        let textFontAttributes = [
            NSFontAttributeName: textFont,
            NSForegroundColorAttributeName: textColor,
        ]

        let cgsize = CGFloat(size)
//        rect.offsetInPlace(dx: cgsize / 2, dy: cgsize / 2)
        (text as NSString).draw(in: rect, withAttributes: textFontAttributes)

        UIGraphicsPopContext()

        let outputImage = UIGraphicsGetImageFromCurrentImageContext()

        UIGraphicsEndImageContext()

        return outputImage!
    }
}
