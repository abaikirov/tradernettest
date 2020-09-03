//
//  QuotationsTVC.swift
//  TraderNetTest
//
//  Created by Abai Abakirov on 9/2/20.
//  Copyright © 2020 abaikirov. All rights reserved.
//

import UIKit
import SnapKit
import SwiftEntryKit

class QuotationsTVC: UIViewController {
  var vm: QuotationsTVCVM
  
  private var emptyLabel: UILabel?
  
  private lazy var tableView: UITableView = {
    let tableView = UITableView()
    tableView.allowsSelection = false
    tableView.estimatedRowHeight = UITableView.automaticDimension
    tableView.register(QuotationsCell.self, forCellReuseIdentifier: QuotationsCell.reuseID)
    tableView.dataSource = self
    tableView.delegate = self
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
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    if vm.isConnecting {
      showConnectingNote()
    }
  }
  
  private func setupView() {
    title = "Quotations"
    
    view.addSubview(tableView)
    tableView.snp.makeConstraints { (make) in
      make.edges.equalToSuperview()
    }
  }
  
  private func getAttrs(_ color: UIColor, duration: EKAttributes.DisplayDuration = 2) -> EKAttributes {
    var attrs = EKAttributes.topNote
    attrs.displayMode = EKAttributes.DisplayMode.inferred
    attrs.displayDuration = duration
    attrs.popBehavior = .animated(animation: .translation)
    attrs.entryBackground = .color(color: EKColor(color))
    attrs.statusBar = .inferred
    return attrs
  }
  
  private func getLabelStyle() -> EKProperty.LabelStyle {
    return EKProperty.LabelStyle(
      font: UIFont.systemFont(ofSize: 12),
      color: .white,
      alignment: .center,
      displayMode: EKAttributes.DisplayMode.inferred
    )
  }
  
  private func showErrorNote(_ message: String?) {
    let labelContent = EKProperty.LabelContent(
      text: message ?? "Something went wrong(",
      style: getLabelStyle()
    )
    let contentView = EKNoteMessageView(with: labelContent)
    SwiftEntryKit.display(
      entry: contentView,
      using: getAttrs(
        .tnRed,
        duration: .infinity
      )
    )
  }
  
  private func showConnectedNote() {
    let labelContent = EKProperty.LabelContent(
      text: "Connected!",
      style: getLabelStyle()
    )
    let contentView = EKNoteMessageView(with: labelContent)
    SwiftEntryKit.display(
      entry: contentView,
      using: getAttrs(.tnGreen)
    )
  }
  
  private func showReconnectingNote() {
    let labelContent = EKProperty.LabelContent(
      text: "Reconnecting...",
      style: getLabelStyle()
    )
    let contentView = EKProcessingNoteMessageView(
      with: labelContent,
      activityIndicator: .medium
    )
    SwiftEntryKit.display(
      entry: contentView,
      using: getAttrs(
        .tnBlue,
        duration: .infinity
      )
    )
  }
  
  private func showConnectingNote() {
    let labelContent = EKProperty.LabelContent(
      text: "Connecting...",
      style: getLabelStyle()
    )
    let contentView = EKProcessingNoteMessageView(
      with: labelContent,
      activityIndicator: .medium
    )
    SwiftEntryKit.display(
      entry: contentView,
      using: getAttrs(
        .tnBlue,
        duration: .infinity
      )
    )
  }
}

extension QuotationsTVC: QuotationsView {
  func show(toUpdate: [Int], toAdd: [Int]) {
    tableView.beginUpdates()
    tableView.reloadRows(at: toUpdate.map { IndexPath(item: $0, section: 0) }, with: .automatic)
    tableView.insertRows(at: toAdd.map { IndexPath(item: $0, section: 0) }, with: .automatic)
    tableView.endUpdates()
  }
  
  func showConnect() {
    showConnectedNote()
  }
  
  func showDisconnect() {
    showErrorNote("Disconnected")
  }
  
  func showReconnectAttempt() {
    showReconnectingNote()
  }
  
  func showError(_ message: String?) {
    showErrorNote(message)
  }
  
  func showEmpty() {
    let emptyLabel = UILabel()
    emptyLabel.text = "NO DATA"
    emptyLabel.textColor = UIColor.systemGray3
    emptyLabel.font = UIFont.boldSystemFont(ofSize: 36)
    
    view.addSubview(emptyLabel)
    emptyLabel.snp.makeConstraints { (make) in
      make.center.equalToSuperview()
    }
    
    self.emptyLabel = emptyLabel
  }
  
  func hideEmpty() {
    emptyLabel?.removeFromSuperview()
    emptyLabel = nil
  }
}

extension QuotationsTVC: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { vm.count }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: QuotationsCell.reuseID) as? QuotationsCell else {
      fatalError()
    }
    cell.onBind(q: vm.get(indexPath.row))
    return cell
  }
  
  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    return UIView()
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
