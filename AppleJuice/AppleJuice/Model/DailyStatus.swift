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
    var character: Character
    var steps: Int = 0
    var mileStone: MileStone? = nil
    var isAchieve : Bool {
        mileStone == .tenThousand
    }
    
    // MARK: 일단 모두 기본 값을 배정해 두고 이후 데이터 저장 방식, 캐릭터 지정방식에 따라 변경 가능하도록
    init(id: String = UUID().uuidString ,date: Date = Date(), character: Character = Character(type: .apple)) {
        self.id = id 
        self.date = .now
        self.character = character
    }
    
    init(id: String, date: Date, character: Character, steps: Int, mileStone: MileStone?){
        self.id = id
        self.date = date
        self.character = character
        self.steps = steps
        
    }
    
    static func from(entity: DailyStatusEntity) -> Self {
        
        if entity.isAcheive {
            
        }
        
        return DailyStatus(id: entity.id ?? "", date: entity.createdAt ?? .now, character: Character(type: .apple), steps: Int(entity.steps), mileStone: entity.isAcheive ? .tenThousand  : nil)
    }
}
