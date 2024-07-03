//
//  PriorityView.swift
//  Reminder
//
//  Created by NERO on 7/4/24.
//

import UIKit
import SnapKit

final class PriorityView: BaseView {
    let prioritySegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["낮음", "중간", "높음"])
        segmentedControl.selectedSegmentIndex = 1
        segmentedControl.selectedSegmentTintColor = .customSky
        return segmentedControl
    }()
    
    override func configureHierarchy() {
        self.addSubview(prioritySegmentedControl)
    }
    
    override func configureLayout() {
        prioritySegmentedControl.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).inset(100)
            $0.centerX.equalTo(self.safeAreaLayoutGuide)
            $0.width.equalTo(200)
            $0.height.equalTo(50)
        }
    }
    
    override func configureView() {
        super.configureView()
    }
}
