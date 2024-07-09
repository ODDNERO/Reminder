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
    let emojiLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 70)
        label.alpha = 0.7
        label.textAlignment = .center
        label.contentMode = .scaleAspectFill
        label.layer.borderWidth = 6
        label.layer.cornerRadius = 45
        label.clipsToBounds = true
        return label
    }()
    
    override func configureHierarchy() {
        self.addSubview(prioritySegmentedControl)
        self.addSubview(emojiLabel)
    }
    
    override func configureLayout() {
        prioritySegmentedControl.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).inset(100)
            $0.centerX.equalTo(self.safeAreaLayoutGuide)
            $0.width.equalTo(200)
            $0.height.equalTo(50)
        }
        emojiLabel.snp.makeConstraints {
            $0.top.equalTo(prioritySegmentedControl.snp.bottom).offset(60)
            $0.centerX.equalTo(self.safeAreaLayoutGuide)
            $0.size.equalTo(90)
        }
    }
    
    override func configureView() {
        super.configureView()
    }
}
