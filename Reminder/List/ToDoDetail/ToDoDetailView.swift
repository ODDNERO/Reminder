//
//  ToDoDetailView.swift
//  Reminder
//
//  Created by NERO on 7/4/24.
//

import UIKit

class ToDoDetailView: BaseView {
    var checkButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "circle"), for: .normal)
        button.tintColor = .systemGray4
        button.contentMode = .scaleAspectFit
        return button
    }()
    
    var titleLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .black
        label.contentMode = .left
        return label
    }()
    
    var memoLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .systemGray
        label.contentMode = .left
        return label
    }()
    
    var deadlineLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .systemGray
        label.contentMode = .left
        return label
    }()
    
    var tagLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .systemGray
        label.contentMode = .left
        return label
    }()
    
    var priorityLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .systemGray
        label.contentMode = .left
        return label
    }()
    
    override func configureHierarchy() {
        [checkButton, titleLabel, memoLabel, deadlineLabel].forEach {
            self.addSubview($0)
        }
    }
    
    override func configureLayout() {
        checkButton.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).inset(8)
            $0.leading.equalTo(self.safeAreaLayoutGuide).inset(20)
            $0.size.equalTo(30)
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).inset(8)
            $0.leading.equalTo(checkButton.snp.trailing).offset(10)
        }
        memoLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.leading.equalTo(titleLabel)
        }
        deadlineLabel.snp.makeConstraints {
            $0.top.equalTo(memoLabel.snp.bottom).offset(4)
            $0.leading.equalTo(titleLabel)
            $0.bottom.equalTo(self.safeAreaLayoutGuide).inset(8)
        }
        tagLabel.snp.makeConstraints {
            $0.top.equalTo(deadlineLabel.snp.bottom).offset(4)
            $0.leading.equalTo(titleLabel)
            $0.bottom.equalTo(self.safeAreaLayoutGuide).inset(8)
        }
        priorityLabel.snp.makeConstraints {
            $0.top.equalTo(tagLabel.snp.bottom).offset(4)
            $0.leading.equalTo(titleLabel)
            $0.bottom.equalTo(self.safeAreaLayoutGuide).inset(8)
        }
    }
    
    override func configureView() {
        super.configureView()
    }
}
