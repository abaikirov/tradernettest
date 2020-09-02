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
  
  init() {
    service.delegate = self
  }
  
  var count: Int {
    quotations.count
  }
  
  func get(_ position: Int) -> QuotationVM {
    quotations[position]
  }
  
  func viewDidLoad() {
    service.connect()
  }
  
  private func mapResults(data: [Any]) {
    print(data)
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
    print("updateQuotations \(qArr.count)")
    qArr.forEach { (q) in
      if let update = quotations.firstIndex(where: { (oldQ) -> Bool in
        oldQ.ticker == q.ticker
      }) {
        print("update \(q.ticker)")
        quotations[update].updateQuotation(q)
        updateIndices.append(update)
      } else {
        print("append \(q.ticker)")
        quotations.append(QuotationVMImpl(q))
        addIndices.append(quotations.count - 1)
      }
    }
    if !updateIndices.isEmpty || !addIndices.isEmpty {
      view?.show(toUpdate: updateIndices, toAdd: addIndices)
    }
  }
}

extension QuotationsTVCVMImpl: QuotationsServiceDelegate {
  func onConnect() {
    view?.showConnected()
  }
  
  func onDisconnect() {
    view?.showReconnected()
  }
  
  func onReconnect() {
    view?.showReconnected()
  }
  
  func onError() {
    view?.showError()
  }
  
  func onQuotations(data: [Any]) {
    mapResults(data: data)
  }
}
