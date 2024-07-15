//
//  InteractionType.swift
//  WatchAppleJuice Watch App
//
//  Created by 이종선 on 6/28/24.
//

import SwiftUI

enum InteractionType: Identifiable, CaseIterable {
    case shower
    case tanning
    case sweet
    
    var id: Self {self}
    
    var iconImage : String {
        switch self {
        case .shower:
            "shower.fill"
        case .tanning:
            "sun.max.fill"
        case .sweet:
            "wand.and.stars"
        }
    }
    
    var frameNames: [String] {
        switch self {
        case .shower:
            return ["shower1", "shower2", "shower3", "shower4"]
        case .tanning:
            return ["sun1", "sun2"]
        case .sweet:
            return ["honey1", "honey2", "honey3", "honey4"]
        }
    }
}
