//
//  QuotationsTVCVMImpl.swift
//  TraderNetTest
//
//  Created by Abai Abakirov on 9/2/20.
//  Copyright © 2020 abaikirov. All rights reserved.
//

import Foundation

class QuotationsTVCVMImpl: QuotationsTVCVM {
  weak var view: QuotationsView?
  
  private var quotations: [QuotationVM] = []
  private var service: QuotationsService = QuotationsServiceImpl()
  private var _isConnecting: Bool = false
  
  init() {
    service.delegate = self
  }
  
  var count: Int {
    quotations.count
  }
  
  var isConnecting: Bool {
    _isConnecting
  }
  
  func get(_ position: Int) -> QuotationVM {
    quotations[position]
  }
  
  func viewDidLoad() {
    _isConnecting = true
    service.connect()
  }
  
  private func mapResults(data: [Any]) {
    if let root = data[0] as? [String: [Any]] {
      if let q = root["q"] as? [[String: Any]] {
        let quotations = q.compactMap { Quotation(dictionary: $0) }
        self.updateQuotations(quotations)
      }
    }
  }
  
  private func updateQuotations(_ qArr: [Quotation]) {
    var addIndices: [Int] = []
    var updateIndices: [Int] = []
    qArr.forEach { (q) in
      if let update = quotations.firstIndex(where: { (oldQ) -> Bool in
        oldQ.ticker == q.ticker
      }) {
        quotations[update].updateQuotation(q)
        updateIndices.append(update)
      } else {
        quotations.append(QuotationVMImpl(q))
        addIndices.append(quotations.count - 1)
      }
    }
    if !updateIndices.isEmpty || !addIndices.isEmpty {
      view?.hideEmpty()
      view?.show(toUpdate: updateIndices, toAdd: addIndices)
    } else if quotations.isEmpty {
      view?.showEmpty()
    }
  }
}

extension QuotationsTVCVMImpl: QuotationsServiceDelegate {
  func onConnect() {
    _isConnecting = false
    view?.showConnect()
  }
  
  func onDisconnect() {
    view?.showDisconnect()
  }
  
  func onReconnectAttempt() {
    view?.showReconnectAttempt()
  }
  
  func onError(_ message: String?) {
    view?.showError(message)
  }
  
  func onQuotations(data: [Any]) {
    mapResults(data: data)
  }
}
