//
//  ToDoDetailViewController.swift
//  Reminder
//
//  Created by NERO on 7/4/24.
//

import UIKit
import RealmSwift

class ToDoDetailViewController: BaseViewController<ToDoDetailView> {
    var todoData: ToDo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let todo = todoData {
//            rootView.titleLabel.text = todo.toDoTitle
//            rootView.memoLabel.text = todo.memo
//            rootView.deadlineLabel.text = todo.deadline
//            rootView.tagLabel.text = todo.tag
//            rootView.priorityLabel.text = todo.priority
            
            //임시
            rootView.titleLabel.text = "타이틀"
            rootView.memoLabel.text = "메모"
            rootView.deadlineLabel.text = "마감일"
            rootView.tagLabel.text = "태그"
            rootView.priorityLabel.text = "우선순위"
        }
    }
}

