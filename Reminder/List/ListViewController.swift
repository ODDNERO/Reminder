//
//  ListViewController.swift
//  Reminder
//
//  Created by NERO on 7/2/24.
//

import UIKit
import RealmSwift

final class ListViewController: BaseViewController<ListView>, SendDataDelegate {
    let realm = try! Realm()
    private var list: Results<Todo>? {
        didSet {
            rootView.listTableView.reloadData()
        }
    }
    
    var delegate: SendDataDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingNavigationBar()
        let mainVC = MainViewController()
        mainVC.delegate = self
        list = list?.sorted(byKeyPath: "deadline", ascending: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        let realm = try! Realm()
//        print(realm.configuration.fileURL)
        rootView.listTableView.reloadData()
    }
    
    override func settingDelegate() {
        rootView.listTableView.delegate = self
        rootView.listTableView.dataSource = self
        rootView.listTableView.register(ListTableViewCell.self, forCellReuseIdentifier: ListTableViewCell.identifier)
    }
    
    func sendTodoList(data: RealmSwift.Results<Todo>) {
        list = data
    }
}

extension ListViewController {
    private func settingNavigationBar() {
        let menu = configurePullDownButton()
        let menuButton = UIBarButtonItem(title: nil, image: UIImage(systemName: "ellipsis.circle"), target: nil, action: nil, menu: menu)
        menuButton.tintColor = .systemBlue
        navigationItem.rightBarButtonItem = menuButton
    }

    private func configurePullDownButton() -> UIMenu {
        let byDeadlineAction = UIAction(title: "마감일 순으로 보기") { _ in
            self.list = self.list?.sorted(byKeyPath: "deadline", ascending: true)
        }
        let bytitleAction = UIAction(title: "제목 순으로 보기") { _ in
            self.list = self.list?.sorted(byKeyPath: "toDoTitle", ascending: true)
        }
        return UIMenu(children: [byDeadlineAction, bytitleAction])
    }
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.identifier) as! ListTableViewCell
        let data = list![indexPath.row]
        cell.update(data: data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "삭제") { action, view, completionHandler in
            try! self.realm.write {
                self.realm.delete(self.list![indexPath.row])
            }
            self.rootView.listTableView.reloadData()
        }
        return UISwipeActionsConfiguration(actions: [delete])
    }
}
