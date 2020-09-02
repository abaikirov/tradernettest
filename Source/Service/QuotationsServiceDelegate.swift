//
//  QuotationsServiceDelegate.swift
//  TraderNetTest
//
//  Created by Abai Abakirov on 9/2/20.
//  Copyright © 2020 abaikirov. All rights reserved.
//

import Foundation

protocol QuotationsServiceDelegate: class {
  func onConnect()
  func onDisconnect()
  func onReconnect()
  func onError()
  func onQuotations(data: [Any])
}
