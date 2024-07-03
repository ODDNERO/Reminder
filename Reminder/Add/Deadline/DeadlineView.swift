//
//  DeadlineView.swift
//  Reminder
//
//  Created by NERO on 7/4/24.
//

import UIKit
import SnapKit

final class DeadlineView: BaseView {
    let deadlineDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.locale = Locale(identifier: "ko_KR")
        datePicker.preferredDatePickerStyle = .wheels
        return datePicker
    }()
    
    override func configureHierarchy() {
        self.addSubview(deadlineDatePicker)
    }
    
    override func configureLayout() {
        deadlineDatePicker.snp.makeConstraints {
            $0.center.equalTo(self.safeAreaLayoutGuide)
            $0.height.equalTo(self.safeAreaLayoutGuide).multipliedBy(0.5)
        }
    }
    
    override func configureView() {
        super.configureView()
    }
}
