//
//  AddView.swift
//  Reminder
//
//  Created by NERO on 7/2/24.
//

import UIKit
import SnapKit

final class AddView: BaseView {
    let titleTextField =  {
        let textField = UITextField()
        textField.placeholder = " 제목"
        textField.tintColor = .customSky
        return textField
    }()
    private let dividerView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        return view
    }()
    let memoTextField = {
        let textField = UITextField()
        textField.placeholder = " 메모"
        textField.tintColor = .customSky
        textField.contentMode = .topLeft
        textField.textAlignment = .left
        return textField
    }()
    private let textFieldStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .white
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.distribution = .fillProportionally
        stackView.alignment = .fill
        stackView.layer.cornerRadius = 15
        stackView.clipsToBounds = true
        return stackView
    }()
    
    var deadlineSetView = DataAddView(columnText: "마감일")
    var tagSetView = DataAddView(columnText: "태그")
    var prioritySetView = DataAddView(columnText: "우선 순위")
    var imageAddView = DataAddView(columnText: "이미지 추가")
    private let setViewStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.clipsToBounds = true
        return stackView
    }()
    
    override func configureHierarchy() {
        [titleTextField, dividerView, memoTextField].forEach {
            textFieldStackView.addArrangedSubview($0)
        }
        [deadlineSetView, tagSetView, prioritySetView, imageAddView].forEach {
            setViewStackView.addArrangedSubview($0)
        }
        
        [textFieldStackView, setViewStackView].forEach {
            self.addSubview($0)
        }
    }
    
    override func configureLayout() {
        textFieldStackView.snp.makeConstraints {
            $0.horizontalEdges.top.equalTo(self.safeAreaLayoutGuide).inset(15)
        }
        titleTextField.snp.makeConstraints {
            $0.top.equalToSuperview().offset(2)
            $0.leading.equalToSuperview().offset(12)
            $0.height.equalTo(50)
        }
        dividerView.snp.makeConstraints {
            $0.top.equalTo(titleTextField.snp.bottom)
            $0.horizontalEdges.equalToSuperview().inset(8)
            $0.height.equalTo(1)
        }
        memoTextField.snp.makeConstraints {
            $0.top.equalTo(dividerView.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(12)
            $0.height.equalTo(120)
        }
        
        setViewStackView.snp.makeConstraints {
            $0.top.equalTo(textFieldStackView.snp.bottom).offset(15)
            $0.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(15)
            $0.height.equalToSuperview().multipliedBy(0.4)
        }
    }
    
    override func configureView() {
        self.backgroundColor = .customSky
    }
}
