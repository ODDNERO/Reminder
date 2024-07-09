//
//  PriorityViewController.swift
//  Reminder
//
//  Created by NERO on 7/4/24.
//

import UIKit

final class PriorityViewController: BaseViewController<PriorityView> {
    private let viewModel = PriorityViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        viewModel.inputViewWillDisappearTrigger.value = ()
    }
    
    override func addEventHandler() {
        rootView.prioritySegmentedControl.addTarget(self, action: #selector(segmentedControlChanged), for: .valueChanged)
    }
    @objc private func segmentedControlChanged(segmentedControl: UISegmentedControl) {
        let selectedPriorityIndex = segmentedControl.selectedSegmentIndex
        viewModel.inputPriority.value = Priority.allCases[selectedPriorityIndex]
    }
}

extension PriorityViewController {
    func bindViewModel() {
        viewModel.outputEmoji.bind { emoji in
            self.rootView.emojiLabel.text = emoji
            switch emoji {
            case "😌":
                self.rootView.emojiLabel.layer.borderColor = UIColor.systemGreen.withAlphaComponent(0.7).cgColor
            case "😶":
                self.rootView.emojiLabel.layer.borderColor = UIColor.systemYellow.withAlphaComponent(0.7).cgColor
            case "🧐":
                self.rootView.emojiLabel.layer.borderColor = UIColor.systemRed.withAlphaComponent(0.8).cgColor
            default:
                self.rootView.emojiLabel.layer.borderColor = UIColor.systemGray5.cgColor
            }
        }
        
        viewModel.outputPriority.bind { priority in
            NotificationCenter.default.post(name: NSNotification.Name("toDoInfo"),
                                            object: nil,
                                            userInfo: ["priority": priority])
        }
    }
}
