//
//  QuotationsCell.swift
//  TraderNetTest
//
//  Created by Abai Abakirov on 9/2/20.
//  Copyright © 2020 abaikirov. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class QuotationsCell: UITableViewCell {
  static let reuseID = "\(QuotationsCell.self)"
  
  private lazy var qTicker: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 20)
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
  
  private lazy var qIcon: UIImageView = {
    let iv = UIImageView()
    return iv
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
    
    contentView.addSubview(qIcon)
    qIcon.snp.makeConstraints { (make) in
      make.top.leading.equalToSuperview().inset(8)
      make.height.equalTo(16)
      make.width.equalTo(0)
      make.bottom.equalTo(qLastTradeExchange.snp.top).offset(-4)
    }
    
    contentView.addSubview(qTicker)
    qTicker.snp.makeConstraints { (make) in
      make.top.equalToSuperview().inset(8)
      make.leading.equalTo(qIcon.snp.trailing)
      make.centerY.equalTo(qIcon.snp.centerY)
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
    qPrice.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    qDiffInPercent.setContentHuggingPriority(.defaultHigh, for: .horizontal)
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    qTicker.text = ""
    qLastTradeExchange.text = ""
    qDiffInPercent.text = ""
    qPrice.text = ""
    qIcon.image = nil
    qIcon.snp.updateConstraints { (make) in
      make.width.equalTo(0)
    }
    qTicker.snp.updateConstraints { (make) in
      make.leading.equalTo(qIcon.snp.trailing)
    }
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
    if (q.imageURL != nil) {
      qIcon.kf.setImage(with: q.imageURL) { [unowned self] (result) in
        switch result {
        case .success(let value):
          self.showIcon(value.image.size)
        case .failure(_):
          return
        }
      }
    }
  }
  
  private func showIcon(_ iconSize: CGSize) {
    if iconSize.width > 1 && iconSize.height > 1 {
      qIcon.snp.updateConstraints { (make) in
        make.width.equalTo(16)
      }
      qTicker.snp.updateConstraints { (make) in
        make.leading.equalTo(qIcon.snp.trailing).offset(4)
      }
    }
  }
}
