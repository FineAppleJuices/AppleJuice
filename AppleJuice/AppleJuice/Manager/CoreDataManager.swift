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
    
    private init() {
        mainContext = PersistenceController.shared.container.viewContext
    }
    
    func saveContext() {
        let context = mainContext
        if context.hasChanges {
            do {
                try context.save()
                print("Data successfully saved.")
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func createEntity(dailyStatus: DailyStatus) {
        let entity = DailyStatusEntity(context: mainContext)
        entity.id = dailyStatus.id
        entity.steps = Int16(dailyStatus.steps)
        entity.createdAt = dailyStatus.date
        
        do{
            try mainContext.save()
        } catch {
            print("Failed to save status: \(error)")
        }
        
    }
    
    // 모든 날짜의 데이터를 가져오기
    func fetchAllEntities() -> [DailyStatus] {
        let request: NSFetchRequest<DailyStatusEntity> = DailyStatusEntity.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "createdAt", ascending: false)
        request.sortDescriptors = [sortDescriptor]
                
        do {
            let result = try mainContext.fetch(request)
            return result.map { DailyStatus.from(entity: $0) }
        } catch {
            print("Failed to fetch status: \(error)")
            return []
        }
    }
    
    // 특정 날짜 범위의 데이터를 가져오기 (startDate: 시작날짜, endDate: 끝날짜)
    func fetchEntities(startDate: Date? = nil, endDate: Date? = nil) -> [DailyStatus] {
        let request: NSFetchRequest<DailyStatusEntity> = DailyStatusEntity.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "createdAt", ascending: false)
        request.sortDescriptors = [sortDescriptor]
        
        // 날짜 범위 조건을 NSPredicate 로 추가
        if let start = startDate, let end = endDate {
            let predicate = NSPredicate(format: "createdAt >= %@ AND createdAt <= %@", start as NSDate, end as NSDate)
            request.predicate = predicate
        }
        
        do {
            let result = try mainContext.fetch(request)
            return result.map { DailyStatus.from(entity: $0) }
        } catch {
            print("Failed to fetch status: \(error)")
            return []
        }
    }
    
}
