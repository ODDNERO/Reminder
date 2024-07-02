//
//  ListViewController.swift
//  Reminder
//
//  Created by NERO on 7/2/24.
//

import UIKit
import RealmSwift

final class ListViewController: BaseViewController<ListView> {
    private var list: Results<Todo>!
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingNavigationBar()
        list = realm.objects(Todo.self).sorted(byKeyPath: "deadline", ascending: true)
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
}

extension ListViewController {
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

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.identifier) as! ListTableViewCell
        let data = list[indexPath.row]
        cell.update(data: data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "삭제") { action, view, completionHandler in
            try! self.realm.write {
                self.realm.delete(self.list[indexPath.row])
            }
            self.rootView.listTableView.reloadData()
        }
        return UISwipeActionsConfiguration(actions: [delete])
    }
}
