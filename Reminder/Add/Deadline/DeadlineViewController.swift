//
//  DeadlineViewController.swift
//  Reminder
//
//  Created by NERO on 7/4/24.
//

import UIKit

final class DeadlineViewController: BaseViewController<DeadlineView> {
    private lazy var date = rootView.deadlineDatePicker.date
    private var deadline = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        formatDate()
        NotificationCenter.default.post(name: NSNotification.Name("toDoInfo"),
                                        object: nil,
                                        userInfo: ["deadline": deadline])
    }
}

extension DeadlineViewController {
    private func formatDate() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy. MM. dd (EEE)"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        var stringDate = dateFormatter.string(from: date)
        deadline = stringDate
    }
}
