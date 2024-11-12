//
//  ViewController.swift
//  TheTable
//
//  Created by Nikita Kuzmin on 12.11.2024.
//

import UIKit

final class MainViewController: UIViewController {
    
    // MARK: - Properties
    
    private(set) lazy var contentView = MainContentView()
    
    private lazy var rightButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.title = "Shuffle"
        button.target = self
        button.action = #selector(buttonClick)
        return button
    }()
    
    // MARK: - LifeCycle
    
    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Task 4"
        navigationItem.rightBarButtonItem = rightButton
        configureContentView()
    }
    
    // MARK: - Action

    @objc
    func buttonClick() {
        contentView.shuffleTableView()
    }
}

private extension MainViewController {
    func configureContentView() {
        contentView.configure(.init(
            cellViewModels: Array(0...32).map {
                MainViewTableCellViewModel(title: "\($0)", isSelected: false)
            })
        )
    }
}

