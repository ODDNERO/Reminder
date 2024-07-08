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
    private var customFolders: [Folder] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingNavigationBar()
        list = repository.readAllItem()
        customFolders = repository.readAllFolders()
        print(customFolders)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        customFolders = repository.readAllFolders()
        rootView.listCollectionView.reloadData()
    }
    
    override func settingDelegate() {
        rootView.listCollectionView.delegate = self
        rootView.listCollectionView.dataSource = self
        rootView.listCollectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: MainCollectionViewCell.identifier)
    }
    
    override func addEventHandler() {
        rootView.addToDoButton.addTarget(self, action: #selector(addToDoButtonClicked), for: .touchUpInside)
        rootView.addFolderButton.addTarget(self, action: #selector(addFolderButtonClicked), for: .touchUpInside)
    }
    @objc private func addToDoButtonClicked() {
        let addVC = AddViewController()
        let naviAddVC = UINavigationController(rootViewController: addVC)
        addVC.delegate = self
        present(naviAddVC, animated: true)
    }
    @objc private func addFolderButtonClicked() {
        let addFolderVC = AddFolderViewController()
        let naviAddVC = UINavigationController(rootViewController: addFolderVC)
        addFolderVC.delegate = self
        present(naviAddVC, animated: true)
    }
}

extension MainViewController: AddFolderDelegate {
    func folderAdded(_ folder: Folder) {
        repository.createFolder(folder)
        customFolders.append(folder)
        let customCategory = CustomCategory(name: folder.title, symbolImage: UIImage(systemName: "folder.fill"), color: .systemGray)
        MainListCategory.addCustomCategory(customCategory)
        rootView.listCollectionView.reloadData()
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
    
    private func reloadFlagCount() {
        let flagCount = repository.readAllItem().filter("isFlag == true").count
        rootView.listCollectionView.reloadData()
        
        let indexPath = IndexPath(item: 3, section: 0)
        if let cell = rootView.listCollectionView.cellForItem(at: indexPath) as? MainCollectionViewCell {
            cell.update(category: .Flag, count: flagCount)
        } else {
            rootView.listCollectionView.reloadData()
        }
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
        case .Custom(let customCategory):
            if let customFolder = customFolders.first(where: { $0.title == customCategory.name }) {
                cell.update(category: .Custom(customCategory), count: customFolder.list.count)
            } else {
                cell.update(category: .Custom(customCategory), count: 0)
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = ListViewController()
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
}
