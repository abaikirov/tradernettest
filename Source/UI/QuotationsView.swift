//
//  QuotationsView.swift
//  TraderNetTest
//
//  Created by Abai Abakirov on 9/2/20.
//  Copyright © 2020 abaikirov. All rights reserved.
//

import Foundation

protocol QuotationsView: class {
  var vm: QuotationsTVCVM { get set }
  
  func show(toUpdate: [Int], toAdd: [Int])
  func showConnect()
  func showDisconnect()
  func showReconnectAttempt()
  func showError(_ message: String?)
  func showEmpty()
  func hideEmpty()
  func showLoading()
}
