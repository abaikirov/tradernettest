//
//  Decimal+Extension.swift
//  TraderNetTest
//
//  Created by Abai Abakirov on 9/3/20.
//  Copyright © 2020 abaikirov. All rights reserved.
//

import Foundation

extension Decimal {
  var tnDoubleValue: Double {
    return NSDecimalNumber(decimal: self).doubleValue
  }
}
