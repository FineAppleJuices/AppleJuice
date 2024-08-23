//
//  DailyStatusEntity+CoreDataProperties.swift
//  AppleJuice
//
//  Created by 이종선 on 7/1/24.
//
//

import Foundation
import CoreData


extension DailyStatusEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DailyStatusEntity> {
        return NSFetchRequest<DailyStatusEntity>(entityName: "DailyStatusEntity")
    }

    @NSManaged public var createdAt: Date?
    @NSManaged public var id: String?
    @NSManaged public var steps: Int16

}

extension DailyStatusEntity : Identifiable {

}
