//
//  Todo.swift
//  Reminder
//
//  Created by NERO on 7/2/24.
//

import Foundation
import RealmSwift

class Todo: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted(indexed: true) var toDoTitle: String
    @Persisted var memo: String?
    @Persisted var deadline: String?
    @Persisted var tag: String?
    @Persisted var priority: String?
    
    convenience init(toDoTitle: String, memo: String?, deadline: String, tag: String, priority: String) {
        self.init()
        self.toDoTitle = toDoTitle
        self.memo = memo
        self.deadline = deadline
        self.tag = tag
        self.priority = priority
    }
}
