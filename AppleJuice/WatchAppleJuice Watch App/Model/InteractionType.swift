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
    case wipe
    
    var id: Self {self}
    
    var iconImage : String {
        switch self {
        case .shower:
            "shower.fill"
        case .tanning:
            "sun.max.fill"
        case .wipe:
            "wand.and.stars"
        }
    }
    
    var frameNames: [String] {
        switch self {
        case .shower:
            return ["showerFrame1", "showerFrame2", "showerFrame3"]
        case .tanning:
            return ["tanningFrame1", "tanningFrame2", "tanningFrame3"]
        case .wipe:
            return ["wipeFrame1", "wipeFrame2", "wipeFrame3"] 
        }
    }
    
}
