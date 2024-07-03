//
//  MainViewController.swift
//  Reminder
//
//  Created by NERO on 7/3/24.
//

import UIKit

class MainViewController: BaseViewController<MainView> {

    override func viewDidLoad() {
        super.viewDidLoad()
        settingNavigationBar()
    }
    
    override func addEventHandler() {
        rootView.addToDoButton.addTarget(self, action: #selector(addToDoButtonClicked), for: .touchUpInside)
    }
    @objc private func addToDoButtonClicked() {
        let naviAddVC = UINavigationController(rootViewController: AddViewController())
        present(naviAddVC, animated: true)
    }
}

extension MainViewController {
    private func settingNavigationBar() {
        let menu = configurePullDownButton()
        let menuButton = UIBarButtonItem(title: nil, image: UIImage(systemName: "ellipsis.circle"), target: nil, action: nil, menu: menu)
        menuButton.tintColor = .systemBlue
        navigationItem.rightBarButtonItem = menuButton
    }
    
    private func configurePullDownButton() -> UIMenu {
        let action1 = UIAction(title: "목록 편집") { _ in //임시
        }
        let action2 = UIAction(title: "템플릿") { _ in //임시
        }
        return UIMenu(children: [action1, action2])
    }
}
