//
//  BuyersTableViewDelegate.swift
//  mandayFaktura
//
//  Created by Wojciech Kicior on 04.04.2018.
//  Copyright © 2018 Wojciech Kicior. All rights reserved.
//

import Foundation
import AppKit

fileprivate enum CellIdentifiers {
    static let nameCell = "nameCellId"
}

class BuyersTableViewDelegate: NSObject, NSTableViewDataSource, NSTableViewDelegate {
    let counterpartyInteractor: CounterpartyInteractor
    
    var buyers: [Counterparty] = []
    
    init(counterpartyInteractor: CounterpartyInteractor) {
        self.counterpartyInteractor = counterpartyInteractor
        self.buyers = counterpartyInteractor.getBuyers()
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return buyers.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        var text: String = ""
        var cellIdentifier: String = ""
        
        let item = buyers[row]
        
        if tableColumn == tableView.tableColumns[0] {
            text = item.name
            cellIdentifier = CellIdentifiers.nameCell
        }
        
        if let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: cellIdentifier), owner: nil) as? NSTableCellView {
            cell.textField?.stringValue = text
            return cell
        }
        return nil
    }
    
    func remove(at: Int) {
        buyers.remove(at: at)
        save()
    }
    
    func save() {
        self.counterpartyInteractor.saveBuyers(buyers)
    }
    
    func reloadData() {
        self.buyers = counterpartyInteractor.getBuyers()
    }
    
    func getSelectedBuyer(index: Int) -> Counterparty {
        return self.buyers[index]
    }
}

