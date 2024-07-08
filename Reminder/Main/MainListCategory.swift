//
//  MainListCategory.swift
//  Reminder
//
//  Created by NERO on 7/3/24.
//

import UIKit

//struct CustomCategory {
//    let name: String
//    let symbolImage: UIImage?
//    let color: UIColor
//}

enum MainListCategory: Int, CaseIterable {
    case Today = 0
    case Schedule = 1
    case Total = 2
    case Flag = 3
    case Done = 4
//    case Custom(CustomCategory)
    
    var attribute: (symbolImage: UIImage?, color: UIColor, title: String) {
        switch self {
        case .Today:
            return (symbolImage: UIImage(systemName: "calendar"), color: .systemBlue, title: "오늘")
        case .Schedule:
            return (symbolImage: UIImage(systemName: "calendar"), color: .systemRed, title: "예정")
        case .Total:
            return (symbolImage: UIImage(systemName: "tray.fill"), color: .darkGray, title: "전체")
        case .Flag:
            return (symbolImage: UIImage(systemName: "flag.fill"), color: .systemYellow, title: "깃발 표시")
        case .Done:
            return (symbolImage: UIImage(systemName: "checkmark"), color: .systemGreen, title: "완료됨")
//        case .Custom(let customCategory):
//            return (symbolImage: customCategory.symbolImage, color: customCategory.color, title: customCategory.name)
        }
    }
    
//    static var defaultCases: [MainListCategory] {
//        return [.Today, .Schedule, .Total, .Flag, .Done]
//    }
    
//    static var customCategories: [CustomCategory] = []
    
//    static func addCustomCategory(_ customCategory: CustomCategory) {
//        customCategories.append(customCategory)
//    }
    
//    static var allCases: [MainListCategory] {
//        return defaultCases + customCategories.map { MainListCategory.Custom($0) }
//    }
}
