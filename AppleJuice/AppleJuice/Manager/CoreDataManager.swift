//
//  CoreDataManager.swift
//  AppleJuice
//
//  Created by 이종선 on 6/29/24.
//

import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    private let mainContext : NSManagedObjectContext
    
    private init(){
        mainContext = PersistenceController.shared.container.viewContext
    }
    
    
    func createEntity(status: DailyStatus){
        
        let entity = DailyStatusEntity(context: mainContext)
        entity.id = status.id
        entity.steps = Int16(status.steps)
        entity.createdAt = status.date
        entity.isAcheive = status.isAchieve

        do{
            try mainContext.save()
            
        } catch {
            print("Failed to save status: \(error)")
        }
        
    }
    
    func fetchAllEntity() -> [DailyStatus]{
        
        let request: NSFetchRequest<DailyStatusEntity> = DailyStatusEntity.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "createdAt", ascending: false)
        request.sortDescriptors = [sortDescriptor]
        
        do {
            let result = try mainContext.fetch(request)
            return result.map{DailyStatus.from(entity: $0)}
        } catch {
        
            print("Failed to fetch status: \(error)")
                   return []
            
        }
    }
}
