//
//  MainContentView.swift
//  TheTable
//
//  Created by Nikita Kuzmin on 12.11.2024.
//

import UIKit

final class MainContentView: UIView {
    
    struct ViewModel {
        let cellViewModels: [MainViewTableCellViewModel]
    }
    
    // MARK: - Properties
    
    private let tableManager: ManagesMainViewTable
    
    private(set) lazy var tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.dataSource = tableManager
        view.delegate = tableManager
        view.layer.cornerRadius = 20
        view.tableHeaderView = UIView()
        return view
    }()
    
    // MARK: - Initialization
    
    init(tableManager: ManagesMainViewTable = MainViewTableManager()) {
        self.tableManager = tableManager
        super.init(frame: .zero)
        backgroundColor = .systemGray6
        addSubviws()
        makeConstaints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func shuffleTableView() {
        tableManager.viewModels.shuffle()
        tableView.reloadSections(IndexSet(integersIn: 0..<tableView.numberOfSections), with: .bottom)
    }
    
    func configure(_ viewModel: ViewModel) {
        tableManager.viewModels = viewModel.cellViewModels
        tableView.reloadData()
        
    }
}

// MARK: - Private

private extension MainContentView {
    func addSubviws() {
        addSubview(tableView)
    }
    
    func makeConstaints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor,  constant: -20),
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor,  constant: 20),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
        ])
    }
}
