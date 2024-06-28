//
//  DailyStatus.swift
//  AppleJuice
//
//  Created by 이종선 on 6/28/24.
//

import Foundation

struct DailyStatus : Identifiable {
    
    let id: String = UUID().uuidString
    let date: Date
    var character: Character
    var steps: Int = 0
    var mileStone: MileStone? = nil
    var isAchieve : Bool {
        mileStone == .tenThousand
    }
    
    // MARK: 일단 모두 기본 값을 배정해 두고 이후 데이터 저장 방식, 캐릭터 지정방식에 따라 변경 가능하도록
    init(date: Date = Date(), character: Character = Character(type: .apple)) {
        self.date = .now
        self.character = character
    }
}
