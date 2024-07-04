//
//  ListViewController.swift
//  Reminder
//
//  Created by NERO on 7/2/24.
//

import UIKit
import RealmSwift

final class ListViewController: BaseViewController<ListView> {
    
    var delegate: ReloadListDelegate?
    let repository = ToDoRepository()
    
    private var list: Results<ToDo>?

    override func viewDidLoad() {
        super.viewDidLoad()
        settingNavigationBar()
        list = repository.readAllItem()
        rootView.listTableView.reloadData()
    }
    
    override func settingDelegate() {
        rootView.listTableView.delegate = self
        rootView.listTableView.dataSource = self
        rootView.listTableView.register(ListTableViewCell.self, forCellReuseIdentifier: ListTableViewCell.identifier)
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
            self.repository.deleteItem(self.list![indexPath.row])
            self.rootView.listTableView.reloadData()
            self.delegate?.reloadList()
        }
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let toDoDetailVC = ToDoDetailViewController()
        toDoDetailVC.todoData = list?[indexPath.row]
        navigationController?.pushViewController(ToDoDetailViewController(), animated: true)
    }
}
