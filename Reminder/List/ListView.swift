//
//  ListView.swift
//  Reminder
//
//  Created by NERO on 7/2/24.
//

import UIKit
import SnapKit

final class ListView: BaseView {
    let categoryLabel = {
        let label = UILabel()
        label.text = "전체" //임시
        label.textColor = .systemBlue //임시
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        return label
    }()
    let listTableView = UITableView()
    
    override func configureHierarchy() {
        [categoryLabel, listTableView].forEach {
            self.addSubview($0)
        }
    }
    
    override func configureLayout() {
        categoryLabel.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).inset(4)
            $0.leading.equalTo(self.safeAreaLayoutGuide).inset(20)
        }
        listTableView.snp.makeConstraints {
            $0.top.equalTo(categoryLabel.snp.bottom).offset(10)
            $0.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            $0.bottom.equalTo(self)
        }
//        listTableView.backgroundColor = .blue //임시
    }
    
    override func configureView() {
        super.configureView()
    }
}
