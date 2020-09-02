//
//  QuotationsService.swift
//  TraderNetTest
//
//  Created by Abai Abakirov on 9/2/20.
//  Copyright © 2020 abaikirov. All rights reserved.
//

import Foundation

protocol QuotationsService {
  var delegate: QuotationsServiceDelegate? { get set }
  
  func connect()
}
