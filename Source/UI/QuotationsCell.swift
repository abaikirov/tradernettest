//
//  QuotationsCell.swift
//  TraderNetTest
//
//  Created by Abai Abakirov on 9/2/20.
//  Copyright © 2020 abaikirov. All rights reserved.
//

import UIKit

class QuotationsCell: UITableViewCell {
  @IBOutlet weak var qTicker: UILabel!
  @IBOutlet weak var qLastTradeExchange: UILabel!
  @IBOutlet weak var qDiffInPercent: UILabel!
  @IBOutlet weak var qPrice: UILabel!
  
  func onBind(q: QuotationVM) {
    qTicker.text = q.ticker
    qLastTradeExchange.text = "\(q.exchange) | \(q.name)"
    qDiffInPercent.text = "\(q.percent)%"
    qPrice.text = "\(q.price) (\(q.change))"
    if (q.isChanged) {
      qDiffInPercent.backgroundColor = q.percentChangedBackColor
      qDiffInPercent.textColor = q.percentChangedColor
    } else {
      qDiffInPercent.backgroundColor = UIColor.clear
      qDiffInPercent.textColor = q.percentColor
    }
  }
}
