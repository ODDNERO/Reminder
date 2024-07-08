//
//  AddFolderView.swift
//  Reminder
//
//  Created by NERO on 7/8/24.
//

import UIKit

final class AddFolderView: BaseView {
    let folderNameTextField = {
        let textField = UITextField()
        textField.placeholder = " 폴더 이름을 입력해 주세요. "
        textField.textAlignment = .center
        textField.textColor = .black
        textField.tintColor = .customSky
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.customSky.cgColor
        textField.layer.cornerRadius = 15
        return textField
    }()
    
    override func configureHierarchy() {
        self.addSubview(folderNameTextField)
    }
    
    override func configureLayout() {
        folderNameTextField.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).inset(100)
            $0.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(30)
            $0.height.equalTo(50)
        }
    }
    
    override func configureView() {
        super.configureView()
    }
}
