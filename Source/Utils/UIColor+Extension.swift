//
//  UIColor+Extension.swift
//  TraderNetTest
//
//  Created by Abai Abakirov on 9/3/20.
//  Copyright © 2020 abaikirov. All rights reserved.
//

import UIKit

extension UIColor {
  convenience init(red: Int, green: Int, blue: Int) {
      assert(red >= 0 && red <= 255, "Invalid red component")
      assert(green >= 0 && green <= 255, "Invalid green component")
      assert(blue >= 0 && blue <= 255, "Invalid blue component")
      
      self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
  }
  
  convenience init(rgb: Int) {
      self.init(
          red: (rgb >> 16) & 0xFF,
          green: (rgb >> 8) & 0xFF,
          blue: rgb & 0xFF
      )
  }
  
  static let tnGreen = UIColor(rgb: 0x00C853)
  static let tnRed = UIColor(rgb: 0xDD2C00)
  static let tnBlue = UIColor(rgb: 0x1976D2)
  static let tnPurple = UIColor(rgb: 0xE91E63)
}
