//
//  QuotationsCell.swift
//  TraderNetTest
//
//  Created by Abai Abakirov on 9/2/20.
//  Copyright © 2020 abaikirov. All rights reserved.
//

import UIKit
import SnapKit

class QuotationsCell: UITableViewCell {
  static let reuseID = "\(QuotationsCell.self)"
  
  private lazy var qTicker: UILabel = {
    let label = UILabel()
    return label
  }()
  
  private lazy var qLastTradeExchange: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 12)
    label.textColor = UIColor.systemGray2
    return label
  }()
  
  private lazy var qDiffInPercent: UILabel = {
    let label = UILabel()
    return label
  }()
  
  private lazy var qPrice: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 12)
    return label
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupView()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupView()
  }
  
  private func setupView() {
    separatorInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
    
    contentView.addSubview(qLastTradeExchange)
    qLastTradeExchange.snp.makeConstraints { (make) in
      make.bottom.leading.equalToSuperview().inset(8)
    }
    
    contentView.addSubview(qTicker)
    qTicker.snp.makeConstraints { (make) in
      make.top.leading.equalToSuperview().inset(8)
      make.bottom.equalTo(qLastTradeExchange.snp.top).offset(-4)
    }
    
    contentView.addSubview(qPrice)
    qPrice.snp.makeConstraints { (make) in
      make.bottom.trailing.equalToSuperview().inset(8)
      make.leading.equalTo(qLastTradeExchange.snp.trailing).offset(4)
    }
    
    contentView.addSubview(qDiffInPercent)
    qDiffInPercent.snp.makeConstraints { (make) in
      make.top.trailing.equalToSuperview().inset(8)
      make.bottom.equalTo(qPrice.snp.top).offset(-4)
      make.leading.equalTo(qTicker.snp.trailing).offset(4)
    }
    
    qLastTradeExchange.setContentHuggingPriority(.defaultLow, for: .horizontal)
    qTicker.setContentHuggingPriority(.defaultLow, for: .horizontal)
  }
  
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
