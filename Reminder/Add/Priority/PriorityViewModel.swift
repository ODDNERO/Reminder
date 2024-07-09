//
//  PriorityViewModel.swift
//  Reminder
//
//  Created by NERO on 7/9/24.
//

import Foundation

enum Priority: String, CaseIterable {
    case low = "낮음"
    case middle = "중간"
    case high = "높음"
}

class PriorityViewModel {
    var inputPriority: Observable<Priority> = Observable(.middle)
    var outputEmoji = Observable("")
    
    var inputViewWillDisappearTrigger: Observable<Void?> = Observable(nil)
    var outputPriority: Observable<String> = Observable("")
    
    init() {
        inputPriority.bind { _ in
            self.matchingEmoji()
        }
        
        inputViewWillDisappearTrigger.bind { _ in
            self.outputPriority.value = self.inputPriority.value.rawValue
        }
    }
}

extension PriorityViewModel {
    private func matchingEmoji() {
        switch inputPriority.value {
        case .low:
            outputEmoji.value = "😌"
        case .middle:
            outputEmoji.value = "😶"
        case .high:
            outputEmoji.value = "🧐"
        }
    }
}
