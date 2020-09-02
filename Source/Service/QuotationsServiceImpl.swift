//
//  QuotationsServiceImpl.swift
//  TraderNetTest
//
//  Created by Abai Abakirov on 9/2/20.
//  Copyright © 2020 abaikirov. All rights reserved.
//

import Foundation
import SocketIO

class QuotationsServiceImpl: QuotationsService {
  private let manager = SocketManager(socketURL: URL(string: Constants.baseURL)!, config: [.log(false), .compress])
  
  weak var delegate: QuotationsServiceDelegate?
  
  func connect() {
    let socket = manager.defaultSocket
    
    socket.on(clientEvent: .connect) { [unowned self] data, ack in
      self.delegate?.onConnect()
      socket.emit("sup_updateSecurities2", Constants.tickers)
    }
    
    socket.on("q") { [unowned self]  (data, ack) in
      self.delegate?.onQuotations(data: data)
    }
    
    socket.on(clientEvent: .disconnect) { [unowned self]  (data, ack) in
      self.delegate?.onDisconnect()
    }
    
    socket.on(clientEvent: .reconnect) { [unowned self]  (data, ack) in
      self.delegate?.onReconnect()
    }
    
    socket.on(clientEvent: .error) { (data, ack) in
      self.delegate?.onError()
    }
    
    socket.connect()
  }
}
