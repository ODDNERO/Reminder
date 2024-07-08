//
//  AddViewController.swift
//  Reminder
//
//  Created by NERO on 7/2/24.
//

import UIKit
import RealmSwift
import Toast

final class AddViewController: BaseViewController<AddView> {
    private var deadline = ""
    private var tag = ""
    private var priority = ""
    
    var delegate: ReloadListDelegate?
    let repository = ToDoRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingNavigationBar()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleNotification),
                                               name: NSNotification.Name("toDoInfo"),
                                               object: nil)
    }
    
    override func addEventHandler() {
        rootView.deadlineSetView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(deadlineClicked)))
        rootView.tagSetView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tagClicked)))
        rootView.prioritySetView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(priorityClicked)))
        rootView.imageAddView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageAddClicked)))
    }
}

extension AddViewController {
    @objc func handleNotification(_ notification: Notification) {
        print("handleNotification 실행됨")
        guard let userInfo = notification.userInfo else { return }
        print("userInfo가 존재함")
        
        if let newDeadline = userInfo["deadline"] {
            deadline = newDeadline as! String
            rootView.deadlineSetView.columnLabel.text = deadline
        }
        
        if let newTag = userInfo["tag"] {
            tag = newTag as! String
            rootView.tagSetView.columnLabel.text = "#\(tag)"
        }
        
        if let newPriority = userInfo["priority"] {
            priority = newPriority as! String
            rootView.prioritySetView.columnLabel.text = priority
        }
    }
    
    @objc private func deadlineClicked() {
        navigationController?.pushViewController(DeadlineViewController(), animated: true)
    }
    @objc private func tagClicked() {
        navigationController?.pushViewController(TagViewController(), animated: true)
    }
    @objc private func priorityClicked() {
        navigationController?.pushViewController(PriorityViewController(), animated: true)
    }
    @objc private func imageAddClicked() {
        navigationController?.pushViewController(ImageAddViewController(), animated: true)
    }
}

extension AddViewController {
    private func settingNavigationBar() {
        self.title = "새로운 할 일"
        
        let cancelButton = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(cancelButtonClicked))
        cancelButton.tintColor = .systemBlue
        navigationItem.leftBarButtonItem = cancelButton
        
        let addButton = UIBarButtonItem(title: "추가", style: .plain, target: self, action: #selector(addButtonClicked))
        addButton.tintColor = .systemBlue
        navigationItem.rightBarButtonItem = addButton
    }
    
    @objc private func cancelButtonClicked() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func addButtonClicked() {
        guard checkRequiredFields() else { return }
        let title = rootView.titleTextField.text!
        let memo = rootView.memoTextField.text
        
        let data = ToDo(toDoTitle: title, memo: memo, deadline: deadline, tag: tag, priority: priority)
        repository.createItem(data, category: .Total)
        delegate?.reloadList()
        dismiss(animated: true, completion: nil)
    }
    
    private func checkRequiredFields() -> Bool {
        guard let title = rootView.titleTextField.text, !title.isEmpty else {
            rootView.makeToast("제목을 입력해 주세요!", duration: 1, position: .center)
            return false
        }
        return true
    }
}
