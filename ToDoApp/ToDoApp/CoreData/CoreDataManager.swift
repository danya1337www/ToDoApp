//
//  CoreDataManager.swift
//  ToDoApp
//
//  Created by Danil Chekantsev on 04.06.2026.
//

import CoreData
import UIKit

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    private init() {}
    
    private var appDelegate: AppDelegate {
        UIApplication.shared.delegate as! AppDelegate
    }
    
    private var context: NSManagedObjectContext {
        appDelegate.persistentContainer.viewContext
    }
    
    private func save() {
        appDelegate.saveContext()
    }
    
    // MARK: - CRUD
    
    func createTask(title: String, fullDescription: String) {
        let task = TaskEntity(context: context)
        task.id = UUID()
        task.title = title
        task.fullDescription = fullDescription
        task.status = TaskStatus.new.rawValue
        task.createdAt = Date()
        save()
    }
    
    func fetchTasks() -> [TaskEntity] {
        let request = TaskEntity.fetchRequest()
        let sort = NSSortDescriptor(key: "createdAt", ascending: false)
        request.sortDescriptors = [sort]
        do {
            return try context.fetch(request)
        } catch {
            print("Error \(error)")
            return []
        }
    }
    
    func updateStatus(_ task: TaskEntity, status: TaskStatus) {
        task.status = status.rawValue
        save()
    }
    
    func deleteTask(_ task: TaskEntity) {
        context.delete(task)
        save()
    }
    
    
    
}
