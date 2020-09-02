//
//  Quotation.swift
//  TraderNetTest
//
//  Created by Abai Abakirov on 9/2/20.
//  Copyright © 2020 abaikirov. All rights reserved.
//

import Foundation

struct Quotation {
  let ticker: String //c
  let diffInPercent: Double //pcp
  let lastTradeExchange: String //ltr
  let name: String //name
  let lastTradePrice: Double //ltp
  let change: Double //chg
  let minStep: Double //min_step
  
  init?(dictionary: [String: Any]) {
    guard
      let c = dictionary["c"] as? String,
      let pcp = dictionary["pcp"] as? Double,
      let ltr = dictionary["ltr"] as? String,
      let name = dictionary["name"] as? String,
      let ltp = dictionary["ltp"] as? Double,
      let chg = dictionary["chg"] as? Double,
      let minStep = dictionary["min_step"] as? Double
    else {
        return nil
    }
    
    ticker = c
    diffInPercent = pcp
    lastTradeExchange = ltr
    self.name = name
    lastTradePrice = ltp
    change = chg
    self.minStep = minStep
  }
  
  func getRoundedToMinStepPrice() -> String {
    let denominator = 1 / minStep
    return String(round(lastTradePrice * denominator) / denominator)
  }
}
