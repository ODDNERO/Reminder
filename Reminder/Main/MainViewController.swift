//
//  MainViewController.swift
//  Reminder
//
//  Created by NERO on 7/3/24.
//

import UIKit
import RealmSwift

protocol ReloadListDelegate {
    func reloadList()
}

class MainViewController: BaseViewController<MainView> {
    private let repository = ToDoRepository()
    private var list: Results<ToDo>? {
        didSet {
            rootView.listCollectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingNavigationBar()
        list = repository.readAllItem()
    }
    
    override func settingDelegate() {
        rootView.listCollectionView.delegate = self
        rootView.listCollectionView.dataSource = self
        rootView.listCollectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: MainCollectionViewCell.identifier)
    }
    
    override func addEventHandler() {
        rootView.addToDoButton.addTarget(self, action: #selector(addToDoButtonClicked), for: .touchUpInside)
    }
    @objc private func addToDoButtonClicked() {
        let addVC = AddViewController()
        let naviAddVC = UINavigationController(rootViewController: addVC)
        addVC.delegate = self
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

extension MainViewController: ReloadListDelegate {
    func reloadList() {
        list = repository.readAllItem()
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MainListCategory.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let category = MainListCategory.allCases[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.identifier, for: indexPath) as! MainCollectionViewCell
        
        switch category {
        case .Today:
            cell.update(category: .Today, count: 0) //임시
        case .Schedule:
            cell.update(category: .Schedule, count: 0) //임시
        case .Total:
            let count = list?.count ?? 0
            cell.update(category: .Total, count: count)
        case .Flag:
            cell.update(category: .Flag, count: 0) //임시
        case .Done:
            cell.update(category: .Done, count: nil)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigationController?.pushViewController(ListViewController(), animated: true)
    }
}
