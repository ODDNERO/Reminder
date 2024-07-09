//
//  DeadlineViewModel.swift
//  Reminder
//
//  Created by NERO on 7/9/24.
//

import Foundation

class DeadlineViewModel {
    private let dateFormatter = DateFormatter()
    
    var inputDate: Observable<Date> = Observable(.now)
    var outputDay = Observable("")
    
    var inputViewWillDisappearTrigger: Observable<Void?> = Observable(nil)
    var outputDeadline: Observable<String> = Observable("")
    
    init() {
        inputDate.bind { _ in
            self.formatDay()
        }
        
        inputViewWillDisappearTrigger.bind { _ in
            self.formatDate()
        }
    }
}

extension DeadlineViewModel {
    private func formatDate() {
        dateFormatter.dateFormat = "yyyy. MM. dd (EEE)"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        var stringDate = dateFormatter.string(from: inputDate.value)
        outputDeadline.value = stringDate
    }
    
    private func formatDay() {
        dateFormatter.dateFormat = "EEE"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        let stringDate = self.dateFormatter.string(from: inputDate.value) + "요일"
        outputDay.value = stringDate
    }
}
