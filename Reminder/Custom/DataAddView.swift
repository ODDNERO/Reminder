//
//  DataAddView.swift
//  Reminder
//
//  Created by NERO on 7/3/24.
//

import UIKit
import SnapKit

final class DataAddView: UIView {
    var columnLabel = {
        let label = UILabel()
        label.textColor = .black
        label.contentMode = .left
        label.font = .systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    private let rightImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.tintColor = .systemCyan
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    init(columnText: String) {
        super.init(frame: .zero)
        self.backgroundColor = .white
        self.layer.cornerRadius = 15
        self.isUserInteractionEnabled = true
        columnLabel.text = columnText
        configureHierarchy()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DataAddView {
    private func configureHierarchy() {
        [columnLabel, rightImageView].forEach {
            self.addSubview($0)
        }
    }
    
    private func configureLayout() {
        columnLabel.snp.makeConstraints {
            $0.centerY.equalTo(self)
            $0.leading.equalTo(self).offset(12)
        }
        rightImageView.snp.makeConstraints {
            $0.centerY.equalTo(self)
            $0.trailing.equalTo(self).offset(-12)
            $0.size.equalTo(20)
        }
    }
}
