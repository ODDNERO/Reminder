//
//  MainView.swift
//  Reminder
//
//  Created by NERO on 7/3/24.
//

import UIKit
import SnapKit

final class MainView: BaseView {
    private let templateLabel = {
        let label = UILabel()
        label.text = "전체" //임시
        label.textColor = .systemGray3
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        return label
    }()
    
    let addToDoButton = {
        let button = UIButton()
        var configuration = UIButton.Configuration.plain()
        configuration.image = UIImage(systemName: "plus.circle.fill")
        configuration.imagePlacement = .leading
        configuration.imagePadding = 8
        configuration.title = "새로운 할 일"
        configuration.titleAlignment = .trailing
        configuration.baseForegroundColor = .systemBlue
        button.configuration = configuration
        return button
    }()
    let addListButton = {
        let button = UIButton()
        button.setTitle("목록 추가", for: .normal)
        button.tintColor = .systemBlue
        return button
    }()
    
    override func configureHierarchy() {
        [templateLabel, addToDoButton, addListButton].forEach {
            self.addSubview($0)
        }
    }
    
    override func configureLayout() {
        templateLabel.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).inset(4)
            $0.leading.equalTo(self.safeAreaLayoutGuide).inset(20)
        }
        addToDoButton.snp.makeConstraints {
            $0.leading.bottom.equalTo(self.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(50)
        }
        addListButton.snp.makeConstraints {
            $0.trailing.bottom.equalTo(self.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(50)
        }
    }
    
    override func configureView() {
        super.configureView()
    }
}

