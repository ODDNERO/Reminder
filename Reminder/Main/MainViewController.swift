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
    private lazy var folders = repository.readAllFolders()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingNavigationBar()
    }
    
    override func settingDelegate() {
        rootView.listCollectionView.delegate = self
        rootView.listCollectionView.dataSource = self
        rootView.listCollectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: MainCollectionViewCell.identifier)
    }
    
    override func addEventHandler() {
        rootView.addToDoButton.addTarget(self, action: #selector(addToDoButtonClicked), for: .touchUpInside)
        //        rootView.addFolderButton.addTarget(self, action: #selector(addFolderButtonClicked), for: .touchUpInside)
    }
    @objc private func addToDoButtonClicked() {
        let addVC = AddViewController()
        let naviAddVC = UINavigationController(rootViewController: addVC)
        addVC.delegate = self
        present(naviAddVC, animated: true)
    }
    //    @objc private func addFolderButtonClicked() {
    //        let addFolderVC = AddFolderViewController()
    //        let naviAddVC = UINavigationController(rootViewController: addFolderVC)
    //        addFolderVC.delegate = self
    //        present(naviAddVC, animated: true)
    //    }
}

//extension MainViewController: AddFolderDelegate {
//    func folderAdded(_ folder: Folder) {
//        repository.createFolder(folder)
//        customFolders.append(folder)
//        let customCategory = CustomCategory(name: folder.title, symbolImage: UIImage(systemName: "folder.fill"), color: .systemGray)
//        MainListCategory.addCustomCategory(customCategory)
//        rootView.listCollectionView.reloadData()
//    }
//}

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
    
//    private func reloadFlagCount() {
//        let flagCount = repository.readAllItem().filter("isFlag == true").count
//        rootView.listCollectionView.reloadData()
//        
//        let indexPath = IndexPath(item: 3, section: 0)
//        if let cell = rootView.listCollectionView.cellForItem(at: indexPath) as? MainCollectionViewCell {
//            cell.update(category: .Flag, count: flagCount)
//        } else {
//            rootView.listCollectionView.reloadData()
//        }
//    }
}

extension MainViewController: ReloadListDelegate {
    func reloadList() {
        folders = repository.readAllFolders()
        rootView.listCollectionView.reloadData()
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return folders.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let category = MainListCategory.allCases[indexPath.item]
        let folder = folders[indexPath.item]
        let count = folder.list.count
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.identifier, for: indexPath) as! MainCollectionViewCell
        
        switch category {
        case .Done:
            cell.update(category: category, count: nil)
        default:
            cell.update(category: category, count: count)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let listVC = ListViewController()
        listVC.folder = folders[indexPath.item]
        listVC.category = MainListCategory.allCases[indexPath.item]
        listVC.delegate = self
        navigationController?.pushViewController(listVC, animated: true)
    }
}
