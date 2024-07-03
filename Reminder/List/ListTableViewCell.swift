//
//  ListTableViewCell.swift
//  Reminder
//
//  Created by NERO on 7/2/24.
//

import UIKit

final class ListTableViewCell: UITableViewCell {
    private let checkButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "circle"), for: .normal)
        button.tintColor = .systemGray4
        button.contentMode = .scaleAspectFit
        return button
    }()
    
    private let titleLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .black
        label.contentMode = .left
        return label
    }()
    
    private let memoLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .systemGray
        label.contentMode = .left
        return label
    }()
    
    private let deadlineLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .systemGray
        label.contentMode = .left
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func update(data: Todo) {
        titleLabel.text = data.toDoTitle
        memoLabel.text = data.memo
        deadlineLabel.text = data.deadline
    }
}

extension ListTableViewCell {
    private func configureHierarchy() {
        [checkButton, titleLabel, memoLabel, deadlineLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    private func configureLayout() {
        checkButton.snp.makeConstraints {
            $0.top.equalTo(contentView.safeAreaLayoutGuide).inset(8)
            $0.leading.equalTo(contentView.safeAreaLayoutGuide).inset(20)
            $0.size.equalTo(30)
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(contentView.safeAreaLayoutGuide).inset(8)
            $0.leading.equalTo(checkButton.snp.trailing).offset(10)
        }
        memoLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.leading.equalTo(titleLabel)
        }
        deadlineLabel.snp.makeConstraints {
            $0.top.equalTo(memoLabel.snp.bottom).offset(4)
            $0.leading.equalTo(titleLabel)
            $0.bottom.equalTo(contentView.safeAreaLayoutGuide).inset(8)
        }
    }
    
    private func configureView() {
        self.selectionStyle = .none
    }
}
