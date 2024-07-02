//
//  ListView.swift
//  Reminder
//
//  Created by NERO on 7/2/24.
//

import UIKit
import SnapKit

final class ListView: BaseView {
    private let categoryLabel = {
        let label = UILabel()
        label.text = "전체" //임시
        label.textColor = .systemBlue //임시
        return label
    }()
    let listTableView = UITableView()
    
    override func configureHierarchy() {
        
    }
    
    override func configureLayout() {
        
    }
    
    override func configureView() {
        super.configureView()
    }
}
