//
//  ProjectsViewModel.swift
//  PGame
//
//  Created by IGOR on 27/09/2024.
//

import SwiftUI
import CoreData

final class ProjectsViewModel: ObservableObject {
    
    @AppStorage("progressActive") var progressActive: Int = 0
    
    @Published var statuses: [String] = ["In Progress", "Completed", "On Pause"]
    @Published var currentStatus = "In Progress"
    
    @Published var isAdd: Bool = false
    @Published var isAddCat: Bool = false
    @Published var isDelete: Bool = false
    @Published var isDetail: Bool = false
    @Published var isAddTask: Bool = false
    @Published var isSettings: Bool = false
    
    @AppStorage("categoties") var categories: [String] = ["All"]
    @Published var currentCategory = "All"
    @Published var category = ""
    @Published var categoryForAdd = "All"
    
    @Published var taskTitle = ""
    @Published var taskDate: Date = Date()
    @Published var taskCat = ""

    @Published var tasks: [TaskModel] = []
    @Published var selectedTask: TaskModel?
    
    func addTask() {
        
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let loan = NSEntityDescription.insertNewObject(forEntityName: "TaskModel", into: context) as! TaskModel
        
        loan.taskTitle = taskTitle
        loan.taskDate = taskDate
        loan.taskCat = taskCat

        CoreDataStack.shared.saveContext()
    }
    
    func fetchTasks() {
        
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<TaskModel>(entityName: "TaskModel")
        
        do {
            
            let result = try context.fetch(fetchRequest)
            
            self.tasks = result
            
        } catch let error as NSError {
            
            print("catch")
            
            print("Error fetching persons: \(error), \(error.userInfo)")
            
            self.tasks = []
        }
    }
    
    @Published var notTask = ""
    @Published var notText = ""
    
    @Published var notes: [NotesModel] = []
    @Published var selectedNote: NotesModel?
    
    func addNote() {
        
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let loan = NSEntityDescription.insertNewObject(forEntityName: "NotesModel", into: context) as! NotesModel
        
        loan.notTask = notTask
        loan.notText = notText

        CoreDataStack.shared.saveContext()
    }
    
    func fetchNotes() {
        
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NotesModel>(entityName: "NotesModel")
        
        do {
            
            let result = try context.fetch(fetchRequest)
            
            self.notes = result
            
        } catch let error as NSError {
            
            print("catch")
            
            print("Error fetching persons: \(error), \(error.userInfo)")
            
            self.notes = []
        }
    }
}
