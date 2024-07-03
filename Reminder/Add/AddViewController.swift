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

    override func viewDidLoad() {
        super.viewDidLoad()
        settingNavigationBar()
    }
    
    override func addEventHandler() {
        rootView.deadlineSetView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(deadlineClicked)))
        rootView.tagSetView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tagClicked)))
        rootView.prioritySetView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(priorityClicked)))
        rootView.imageAddView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageAddClicked)))
    }
}

extension AddViewController {
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
        let deadline = Date() //임시
        let tag = ""
        let priority = 0
        
        let realm = try! Realm()
        let data = Todo(toDoTitle: title, memo: memo, deadline: deadline, tag: tag, priority: priority)
        try! realm.write { realm.add(data) }
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
