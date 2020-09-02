//
//  QuotationsTVC.swift
//  TraderNetTest
//
//  Created by Abai Abakirov on 9/2/20.
//  Copyright © 2020 abaikirov. All rights reserved.
//

import UIKit
import SocketIO

class QuotationsTVC: UITableViewController, QuotationsView {
  var vm: QuotationsTVCVM!
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    setup()
  }
  
  override init(style: UITableView.Style) {
    super.init(style: style)
    setup()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setup()
  }
  
  private func setup() {
    vm = QuotationsTVCVMImpl()
    vm.view = self
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    vm.viewDidLoad()
  }
  
  func show(toUpdate: [Int], toAdd: [Int]) {
    tableView.beginUpdates()
    tableView.reloadRows(at: toUpdate.map { IndexPath(item: $0, section: 0) }, with: .automatic)
    tableView.insertRows(at: toAdd.map { IndexPath(item: $0, section: 0) }, with: .automatic)
    tableView.endUpdates()
  }
  
  func showConnected() {
    //TODO
  }
  
  func showDisconnected() {
    //TODO
  }
  
  func showReconnected() {
    //TODO
  }
  
  func showError() {
    //TODO
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    vm.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "quotationsCell") as? QuotationsCell else {
      fatalError()
    }
    cell.onBind(q: vm.get(indexPath.row))
    return cell
  }
}
