//
//  ToDoRepository.swift
//  Reminder
//
//  Created by NERO on 7/4/24.
//

import Foundation
import RealmSwift

final class ToDoRepository {
    let realm = try! Realm()
    private var folders: Results<Folder>
    
    init() {
        print(realm.configuration.fileURL)
        folders = realm.objects(Folder.self)
        if folders.isEmpty {
            MainListCategory.allCases.forEach {
                createFolder(Folder(title: $0.attribute.title))
            }
        }
    }
    
    func createFolder(_ folder: Folder) {
        do {
            try realm.write {
                realm.add(folder)
            }
        } catch {
            print("Create Folder Error: \(error)")
        }
    }
    
    func readAllFolders() -> [Folder] {
        return Array(realm.objects(Folder.self))
    }
    
    func createItem(_ data: ToDo, category: MainListCategory) {
        let folder = folders[category.rawValue]
        
        do {
            try realm.write {
                folder.list.append(data)
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
