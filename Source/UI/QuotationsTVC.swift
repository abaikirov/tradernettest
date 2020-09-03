//
//  QuotationsTVC.swift
//  TraderNetTest
//
//  Created by Abai Abakirov on 9/2/20.
//  Copyright © 2020 abaikirov. All rights reserved.
//

import UIKit
import SnapKit

class QuotationsTVC: UIViewController {
  var vm: QuotationsTVCVM
  
  private lazy var tableView: UITableView = {
    let tableView = UITableView()
    tableView.register(QuotationsCell.self, forCellReuseIdentifier: QuotationsCell.reuseID)
    tableView.dataSource = self
    return tableView
  }()
  
  init(vm: QuotationsTVCVM) {
    self.vm = vm
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
    vm.viewDidLoad()
  }
  
  private func setupView() {
    title = "Quotations"
    
    view.addSubview(tableView)
    tableView.snp.makeConstraints { (make) in
      make.edges.equalToSuperview()
    }
  }
}

extension QuotationsTVC: QuotationsView {
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
}

extension QuotationsTVC: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { vm.count }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: QuotationsCell.reuseID) as? QuotationsCell else {
      fatalError()
    }
    cell.onBind(q: vm.get(indexPath.row))
    return cell
  }
}

extension QuotationsTVC {
  static func instance() -> QuotationsTVC {
    let vm = QuotationsTVCVMImpl()
    let vc = QuotationsTVC(vm: vm)
    vm.view = vc
    return vc
  }
  
  static func instanceInNavigation() -> UINavigationController {
    let nav = UINavigationController(rootViewController: instance())
    nav.navigationBar.prefersLargeTitles = true
    return nav
  }
}
