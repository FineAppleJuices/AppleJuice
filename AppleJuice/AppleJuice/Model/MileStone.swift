//
//  MileStone.swift
//  AppleJuice
//
//  Created by 이종선 on 6/28/24.
//

import Foundation

enum MileStone : Int {
    case oneThousand = 1000
    case fiveThousand = 5000
    case tenThousand = 10000
    
    var description: String {
        switch self {
        case .oneThousand:
            return "1000걸음 달성"
        case .fiveThousand:
            return "5000걸음 달성"
        case .tenThousand:
            return "10000걸음 달성"
        }
    }
    
    var message: String {
        switch self {
        case .oneThousand:
            return "산뜻한 시작 🌼"
        case .fiveThousand:
            return "벌써 반이나!! 😲"
        case .tenThousand:
            return "오늘 하루도 고생많았어요👍"
        }
    }
    
    var iconName: String {
        switch self {
        case .oneThousand:
            "carrot.fill"
        case .fiveThousand:
            "heart.fill"
        case .tenThousand:
            "crown.fill"
        }
    }
}
