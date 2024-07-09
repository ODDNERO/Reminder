//
//  DeadlineView.swift
//  Reminder
//
//  Created by NERO on 7/4/24.
//

import UIKit
import SnapKit

final class DeadlineView: BaseView {
    let dayLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .systemCyan
        label.textAlignment = .center
        label.layer.borderWidth = 2
        label.layer.borderColor = UIColor.customSky.withAlphaComponent(0.6).cgColor
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        return label
    }()
    let deadlineDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.locale = Locale(identifier: "ko_KR")
        datePicker.preferredDatePickerStyle = .wheels
        return datePicker
    }()
    
    override func configureHierarchy() {
        self.addSubview(dayLabel)
        self.addSubview(deadlineDatePicker)
    }
    
    override func configureLayout() {
        dayLabel.snp.makeConstraints {
            $0.centerX.equalTo(self.safeAreaLayoutGuide)
            $0.bottom.equalTo(deadlineDatePicker.snp.top).offset(-10)
            $0.width.equalTo(100)
            $0.height.equalTo(50)
        }
        deadlineDatePicker.snp.makeConstraints {
            $0.center.equalTo(self.safeAreaLayoutGuide)
            $0.height.equalTo(self.safeAreaLayoutGuide).multipliedBy(0.5)
        }
    }
    
    override func configureView() {
        super.configureView()
    }
}
