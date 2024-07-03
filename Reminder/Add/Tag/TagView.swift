//
//  TagView.swift
//  Reminder
//
//  Created by NERO on 7/4/24.
//

import UIKit
import SnapKit

final class TagView: BaseView {
    let tagTextField = {
        let textField = UITextField()
        textField.placeholder = " 태그를 입력해 주세요 "
        textField.textAlignment = .center
        textField.textColor = .black
        textField.tintColor = .customSky
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.customSky.cgColor
        textField.layer.cornerRadius = 15
        return textField
    }()
    
    override func configureHierarchy() {
        self.addSubview(tagTextField)
    }
    
    override func configureLayout() {
        tagTextField.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).inset(100)
            $0.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(30)
            $0.height.equalTo(50)
        }
    }
    
    override func configureView() {
        super.configureView()
    }
}
