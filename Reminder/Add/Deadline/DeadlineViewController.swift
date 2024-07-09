//
//  DeadlineViewController.swift
//  Reminder
//
//  Created by NERO on 7/4/24.
//

import UIKit

final class DeadlineViewController: BaseViewController<DeadlineView> {
    private let viewModel = DeadlineViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    override func addEventHandler() {
        rootView.deadlineDatePicker.addTarget(self, action: #selector(datePickerChanged), for: .valueChanged)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        viewModel.inputViewWillDisappearTrigger.value = ()
    }
    
    @objc private func datePickerChanged(datePicker: UIDatePicker) {
        viewModel.inputDate.value = datePicker.date
    }
}

extension DeadlineViewController {
    func bindViewModel() {
        viewModel.outputDay.bind { day in
            self.rootView.dayLabel.text = day
        }
        
        viewModel.outputDeadline.bind { deadline in
            NotificationCenter.default.post(name: NSNotification.Name("toDoInfo"),
                                            object: nil,
                                            userInfo: ["deadline": deadline])
        }
    }
}
