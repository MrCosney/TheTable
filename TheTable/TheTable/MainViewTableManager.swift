//
//  MainViewTableManager.swift
//  TheTable
//
//  Created by Nikita Kuzmin on 12.11.2024.
//

import UIKit

protocol ManagesMainViewTable: UITableViewDataSource, UITableViewDelegate {
    var viewModels: [MainViewTableCellViewModel] { get set }
}

final class MainViewTableManager: NSObject, ManagesMainViewTable {
    
    var viewModels: [MainViewTableCellViewModel] = []
}

// MARK: - UITableViewDataSource

extension MainViewTableManager {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        if let reuseCell = tableView.dequeueReusableCell(withIdentifier: "cell") {
            cell = reuseCell
        } else {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        }
        let row = viewModels[indexPath.row]
        var configuration = cell.defaultContentConfiguration()
        configuration.text = viewModels[indexPath.row].title
        cell.accessoryType = row.isSelected ? .checkmark : .none
        cell.contentConfiguration = configuration
        return cell
    }
}

// MARK: - UITableViewDelegate

extension MainViewTableManager {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        viewModels[indexPath.row].isSelected.toggle()
        tableView.reloadRows(at: [indexPath], with: .none)
        
        let itemToMove = viewModels[indexPath.row]
        guard indexPath.row != 0, itemToMove.isSelected else { return }
        
        
        viewModels.remove(at: indexPath.row)
        viewModels.insert(itemToMove, at: 0)
        tableView.performBatchUpdates({
            tableView.moveRow(at: indexPath, to: IndexPath(row: 0, section: 0))
        }, completion: nil)
    }
    
}
