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
    q.name ?? "---------"
  }
  
  var ticker: String {
    q.ticker
  }
  
  var exchange: String {
    q.lastTradeExchange ?? "----"
  }
  
  var percent: String {
    if q.diffInPercent != nil {
      return "\(q.diffInPercent!)"
    } else {
      return "---"
    }
  }
  
  var price: String {
    if q.lastTradePrice != nil {
      return "\(q.lastTradePrice!)"
    } else {
      return "---"
    }
  }
  
  var change: String {
    if q.change != nil {
      return "\(q.change!)"
    } else {
      return "---"
    }
  }
  
  var percentColor: UIColor {
    guard let diff = q.diffInPercent else { return UIColor.systemGray2 }
    if (diff > 0) {
      return .tnGreen
    } else if (diff < 0) {
      return .tnRed
    } else {
      return .systemGray2
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
      return .tnGreen
    } else if (diff < 0) {
      return .tnRed
    } else {
      return .clear
    }
  }
  
  var percentChangedColor: UIColor {
    guard let oldP = oldPercent else { return percentColor }
    guard let newP = q.diffInPercent else { return percentColor }
    let diff = newP - oldP
    if (diff == 0) {
      return percentColor
    } else {
      return .white
    }
  }
  
  var imageURL: URL? {
    URL(string: "\(Constants.imageURL)\(q.ticker.lowercased())")
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
