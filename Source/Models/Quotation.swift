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
  var lastTradePrice: Decimal? //ltp
  var change: Decimal? //chg
  var minStep: Decimal? //min_step
  
  var roundedLastPrice: Decimal? {
    guard let minStep = minStep, let price = lastTradePrice else { return nil }
    return qRound(minStep, price)
  }
  
  var roundedChange: Decimal? {
    guard let minStep = minStep, let price = change else { return nil }
    return qRound(minStep, price)
  }
  
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
    let ltp = dictionary["ltp"] as? Double
    lastTradePrice = ltp?.tnDecimalValue
    let chg = dictionary["chg"] as? Double
    change = chg?.tnDecimalValue
    let step = dictionary["min_step"] as? Double
    minStep = step?.tnDecimalValue
    
    if let nameData = name?.data(using: .isoLatin1) {
      if let decodedName = String(data: nameData, encoding: .utf8) {
        name = decodedName
      }
    }
  }
  
  private func qRound(_ step: Decimal, _ price: Decimal) -> Decimal? {
    let denominator = 1 / step
    if let rounded = round((price * denominator).tnDoubleValue).tnDecimalValue {
      return rounded / denominator
    }
    return nil
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
