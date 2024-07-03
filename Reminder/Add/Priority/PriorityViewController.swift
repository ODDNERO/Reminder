//
//  PriorityViewController.swift
//  Reminder
//
//  Created by NERO on 7/4/24.
//

import UIKit

final class PriorityViewController: BaseViewController<PriorityView> {
    private lazy var selectedPriorityIndex = rootView.prioritySegmentedControl.selectedSegmentIndex
    private lazy var priority = rootView.prioritySegmentedControl.titleForSegment(at: selectedPriorityIndex)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.post(name: NSNotification.Name("toDoInfo"),
                                        object: nil,
                                        userInfo: ["priority": priority])
    }
}
