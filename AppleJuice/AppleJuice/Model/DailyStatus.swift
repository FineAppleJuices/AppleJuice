//
//  DailyStatus.swift
//  AppleJuice
//
//  Created by 이종선 on 6/28/24.
//

import Foundation

struct DailyStatus : Identifiable {
    
    let id: String
    let date: Date
    var steps: Int = 0
    
    static func from(entity: DailyStatusEntity) -> Self {
        
        return DailyStatus(id: entity.id ?? "", date: entity.createdAt ?? .now, steps: Int(entity.steps))
    }
}
