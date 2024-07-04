//
//  ToDoDetailViewController.swift
//  Reminder
//
//  Created by NERO on 7/4/24.
//

import UIKit
import RealmSwift

class ToDoDetailViewController: BaseViewController<ToDoDetailView>, SendDataDelegate {
    func sendTodoList(data: RealmSwift.Results<Todo>) {
        rootView.deadlineLabel.text = data[0].deadline
        rootView.tagLabel.text = data[0].tag
        rootView.priorityLabel.text = data[0].priority
        rootView.titleLabel.text = data[0].toDoTitle
        rootView.memoLabel.text = data[0].memo
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let listVC = ListViewController()
        listVC.delegate = self
    }
}
