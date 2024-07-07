//
//  ToDoRepository.swift
//  Reminder
//
//  Created by NERO on 7/4/24.
//

import Foundation
import RealmSwift

final class ToDoRepository {
    private let realm = try! Realm() 
    
    func createItem(_ data: ToDo) {
        do {
            try realm.write {
                realm.add(data)
            }
        } catch {
            print("Create Error: \(error)")
        }
    }
    
    func readAllItem() -> Results<ToDo> {
        return realm.objects(ToDo.self).sorted(byKeyPath: "deadline", ascending: true)
    }
    
    func updateItem<T>(_ data: ToDo, coulmn: String, value: T) {
        do {
            try realm.create(ToDo.self, value: ["id": data.id, coulmn: value], update: .modified)
        } catch {
            print("Update Error: \(error)")
        }
    }
    
    func updateAllItem<T>(coulmn: String, value: T) {
        let result = realm.objects(ToDo.self)
        
        try! realm.write {
            result.setValue(value, forKey: coulmn)
        }
    }
    
    func deleteItem(_ data: ToDo) {
        do {
            try realm.write {
                realm.delete(data)
            }
        } catch {
            print("Delete Error: \(error)")
        }
    }
    
    func filterSearchTitleItem(_ searchText: String) -> Results<ToDo> {
        let filter = realm.objects(ToDo.self).where {
            $0.toDoTitle.contains(searchText)
        }
        let result = searchText.isEmpty ? realm.objects(ToDo.self) : filter
        return result
    }
}
