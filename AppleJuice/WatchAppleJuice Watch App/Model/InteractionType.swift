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
            "button1"
        case .tanning:
            "button2"
        case .sweet:
            "button3"
        }
    }
    
    var frameNames: [String] {
        switch self {
        case .shower:
            return ["bath1", "bath2", "bath3", "bath4"]
        case .tanning:
            return ["sun1", "sun2"]
        case .sweet:
            return ["honey1", "honey2", "honey3", "honey4"]
        }
    }
}
