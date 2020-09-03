//
//  Constants.swift
//  TraderNetTest
//
//  Created by Abai Abakirov on 9/2/20.
//  Copyright © 2020 abaikirov. All rights reserved.
//

import Foundation

struct Constants {
  static let tickers = "RSTI,GAZP,MRKZ,RUAL,HYDR,MRKS,SBER,FEES,TGKA,VTBR,ANH.US,VICL.US,BURG. US,NBL.US,YETI.US,WSFS.US,NIO.US,DXC.US,MIC.US,HSBC.US,EXPN.EU,GSK.EU,SH P.EU,MAN.EU,DB1.EU,MUV2.EU,TATE.EU,KGF.EU,MGGT.EU,SGGD.EU".split(separator: ",")
  
  static let baseURL = "https://ws.tradernet.ru"
  static let imageURL = "https://tradernet.ru/logos/get-logo-by-ticker?ticker="
}
