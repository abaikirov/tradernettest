//
//  QuotationVMImpl.swift
//  TraderNetTest
//
//  Created by Abai Abakirov on 9/2/20.
//  Copyright © 2020 abaikirov. All rights reserved.
//

import Foundation
import UIKit

class QuotationVMImpl: QuotationVM {
  private var q: Quotation
  
  var name: String {
    q.name
  }
  
  var ticker: String {
    q.ticker
  }
  
  var exchange: String {
    q.lastTradeExchange
  }
  
  var percent: String {
    "\(q.diffInPercent)"
  }
  
  var price: String {
    "\(q.lastTradePrice)"
  }
  
  var change: String {
    "\(q.change)"
  }
  
  var percentColor: UIColor {
    if (q.diffInPercent > 0) {
      return UIColor.green
    } else if (q.diffInPercent < 0) {
      return UIColor.red
    } else {
      return UIColor.systemGray2
    }
  }
  
  var isChanged: Bool {
    print("isChanged \(ticker): \(oldPercent != nil && oldPercent != q.diffInPercent) \(oldPercent) \(q.diffInPercent)")
    return oldPercent != nil && oldPercent != q.diffInPercent
  }
  
  var percentChangedBackColor: UIColor {
    guard let oldP = oldPercent else { return UIColor.clear }
    let diff = q.diffInPercent - oldP
    if (diff > 0) {
      return UIColor.green
    } else if (diff < 0) {
      return UIColor.red
    } else {
      return UIColor.clear
    }
  }
  
  var percentChangedColor: UIColor {
    guard let oldP = oldPercent else { return percentColor }
    let diff = q.diffInPercent - oldP
    if (diff == 0) {
      return percentColor
    } else {
      return UIColor.white
    }
  }
  
  private var oldPercent: Double?
  
  init(_ q: Quotation) {
    self.q = q
  }
  
  func updateQuotation(_ newQ: Quotation) {
    print("update: \(q.ticker)->\(newQ.ticker) \(q.diffInPercent)->\(newQ.diffInPercent)")
    oldPercent = q.diffInPercent
    q = newQ
  }
}
