//
//  ListViewController.swift
//  Reminder
//
//  Created by NERO on 7/2/24.
//

import UIKit

final class ListViewController: BaseViewController<ListView> {

    override func viewDidLoad() {
        super.viewDidLoad()
        settingNavigationBar()
    }
    
    private func settingNavigationBar() {
        let addButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addButtonClicked))
        addButton.tintColor = .systemBlue
        navigationItem.leftBarButtonItem = addButton //임시
        
        let menuButton = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle"), style: .plain, target: self, action: #selector(menuButtonClicked))
        menuButton.tintColor = .systemBlue
        navigationItem.rightBarButtonItem = menuButton
    }
    @objc private func addButtonClicked() { //임시
        present(AddViewController(), animated: true)
    }
    @objc private func menuButtonClicked() {
        
    }
}
