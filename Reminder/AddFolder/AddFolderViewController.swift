//
//  AddFolderViewController.swift
//  Reminder
//
//  Created by NERO on 7/8/24.
//

import UIKit

protocol AddFolderDelegate: AnyObject {
    func folderAdded(_ folder: Folder)
}

final class AddFolderViewController: BaseViewController<AddFolderView> {
    var delegate: AddFolderDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingNavigationBar()
    }
    
    private func settingNavigationBar() {
        self.title = "폴더 추가하기"
        
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
        guard let title = rootView.folderNameTextField.text, !title.isEmpty else { return }
        let folder = Folder()
        folder.title = title
        folder.addDate = Date()
        delegate?.folderAdded(folder)
        dismiss(animated: true)
    }
}
