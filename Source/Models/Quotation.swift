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
  var diffInPercent: Double? //pcp
  var lastTradeExchange: String? //ltr
  var name: String? //name
  var lastTradePrice: Double? //ltp
  var change: Double? //chg
  var minStep: Double? //min_step
  
  init?(dictionary: [String: Any]) {
    guard
      let c = dictionary["c"] as? String
    else {
        return nil
    }
    
    ticker = c
    diffInPercent = dictionary["pcp"] as? Double
    lastTradeExchange = dictionary["ltr"] as? String
    name = dictionary["name"] as? String
    lastTradePrice = dictionary["ltp"] as? Double
    change = dictionary["chg"] as? Double
    minStep = dictionary["min_step"] as? Double
  }
  
  func getRoundedToMinStepPrice() -> String {
    guard let minStep = minStep, let price = lastTradePrice else { return "\(lastTradePrice ?? 0.0)" }
    let denominator = 1 / minStep
    return String(round(price * denominator) / denominator)
  }
  
  mutating func update(q: Quotation) {
    if q.diffInPercent != nil {
      diffInPercent = q.diffInPercent
    }
    if q.lastTradeExchange != nil {
      lastTradeExchange = q.lastTradeExchange
    }
    if q.lastTradePrice != nil {
      lastTradePrice = q.lastTradePrice
    }
    if q.change != nil {
      change = q.change
    }
    if q.minStep != nil {
      minStep = q.minStep
    }
    if q.name != nil {
      name = q.name
    }
  }
}
