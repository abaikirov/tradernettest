//
//  QuotationsTVCVM.swift
//  TraderNetTest
//
//  Created by Abai Abakirov on 9/2/20.
//  Copyright © 2020 abaikirov. All rights reserved.
//

import Foundation

protocol QuotationsTVCVM {
  var view: QuotationsView? { get set }
  var count: Int { get }
  
  func viewDidLoad()
  func get(_ position: Int) -> QuotationVM
}
