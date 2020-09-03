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
    q.name ?? ""
  }
  
  var ticker: String {
    q.ticker
  }
  
  var exchange: String {
    q.lastTradeExchange ?? ""
  }
  
  var percent: String {
    "\(q.diffInPercent ?? 0.0)"
  }
  
  var price: String {
    "\(q.lastTradePrice ?? 0.0)"
  }
  
  var change: String {
    "\(q.change ?? 0.0)"
  }
  
  var percentColor: UIColor {
    guard let diff = q.diffInPercent else { return UIColor.systemGray2 }
    if (diff > 0) {
      return UIColor.green
    } else if (diff < 0) {
      return UIColor.red
    } else {
      return UIColor.systemGray2
    }
  }
  
  var isChanged: Bool {
    return oldPercent != nil && oldPercent != q.diffInPercent
  }
  
  var percentChangedBackColor: UIColor {
    guard let oldP = oldPercent else { return UIColor.clear }
    guard let newP = q.diffInPercent else { return UIColor.clear }
    let diff = newP - oldP
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
    guard let newP = q.diffInPercent else { return percentColor }
    let diff = newP - oldP
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
    oldPercent = q.diffInPercent
    q.update(q: newQ)
  }
}
