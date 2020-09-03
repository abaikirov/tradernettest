//
//  QuotationVM.swift
//  TraderNetTest
//
//  Created by Abai Abakirov on 9/2/20.
//  Copyright © 2020 abaikirov. All rights reserved.
//

import Foundation
import UIKit

protocol QuotationVM {
  var name: String { get }
  var ticker: String { get }
  var exchange: String { get }
  var percent: String { get }
  var price: String { get }
  var change: String { get }
  var percentColor: UIColor { get }
  var isChanged: Bool { get }
  var percentChangedBackColor: UIColor { get }
  var percentChangedColor: UIColor { get }
  var imageURL: URL? { get }
  
  func updateQuotation(_ newQ: Quotation)
}
