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
    
    func readFolderItems(category: MainListCategory) -> [ToDo] {
        return Array(folders[category.rawValue].list)
    }
    
    func readAllItem() -> [ToDo] {
        return Array(realm.objects(ToDo.self).sorted(byKeyPath: "deadline", ascending: true))
    }
    
    func sortedList(folder: Folder, byKeyPath: String) -> [ToDo] {
        return Array(folder.list.sorted(byKeyPath: byKeyPath, ascending: true))
    }
    
    func updateItem<T>(_ data: ToDo, coulmn: String, value: T, category: MainListCategory, isAdding: Bool) {
        let folder = folders[category.rawValue]
        do {
            try realm.write {
                realm.create(ToDo.self, value: ["id": data.id, coulmn: value], update: .modified)
                if isAdding {
                    folder.list.append(data)
                } else {
                    guard let index = folder.list.firstIndex(where: { $0.id == data.id }) else { return }
                    folder.list.remove(at: index)
                }
            }
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
    
    func filterSearchTitleItem(_ searchText: String) -> [ToDo] {
        let filter = realm.objects(ToDo.self).where {
            $0.toDoTitle.contains(searchText)
        }
        let result = searchText.isEmpty ? realm.objects(ToDo.self) : filter
        return Array(result)
    }
}
