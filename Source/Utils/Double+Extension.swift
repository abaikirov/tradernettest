//
//  Double+Extension.swift
//  TraderNetTest
//
//  Created by Abai Abakirov on 9/3/20.
//  Copyright © 2020 abaikirov. All rights reserved.
//

import Foundation

extension Double {
  var tnDecimalValue: Decimal? {
    Decimal(string: self.description)
  }
}
