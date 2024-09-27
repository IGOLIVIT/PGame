//
//  NotesViewModel.swift
//  PGame
//
//  Created by IGOR on 27/09/2024.
//

import SwiftUI
import CoreData

final class NotesViewModel: ObservableObject {
    
    @AppStorage("progressActive") var progressActive: Int = 0

    @Published var isAdd: Bool = false
    @Published var isAddCat: Bool = false
    @Published var isDelete: Bool = false
    @Published var isDetail: Bool = false
    
    @AppStorage("categoties") var categories: [String] = ["All"]
    @Published var currentCategory = "All"
    @Published var category = ""
    @Published var categoryForAdd = "All"
    
    @Published var recTitle = ""
    @Published var recDate: Date = Date()
    @Published var recCat = ""
    @Published var recDescr = ""

    @Published var records: [RecModel] = []
    @Published var selectedRecord: RecModel?
    
    func addRecord() {
        
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let loan = NSEntityDescription.insertNewObject(forEntityName: "RecModel", into: context) as! RecModel
        
        loan.recTitle = recTitle
        loan.recDate = recDate
        loan.recCat = recCat
        loan.recDescr = recDescr

        CoreDataStack.shared.saveContext()
    }
    
    func fetchRecords() {
        
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<RecModel>(entityName: "RecModel")
        
        do {
            
            let result = try context.fetch(fetchRequest)
            
            self.records = result
            
        } catch let error as NSError {
            
            print("catch")
            
            print("Error fetching persons: \(error), \(error.userInfo)")
            
            self.records = []
        }
    }

}
