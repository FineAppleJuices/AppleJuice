//
//  Character.swift
//  AppleJuice
//
//  Created by 이종선 on 6/28/24.
//

import Foundation

enum CharacterType: String, Identifiable, CaseIterable {

    case apple
    case pineapple
    
    var id: Self {self}
   
    var normalImage: String {
        switch self {
        case .apple:
            return "apple.normal"
        case .pineapple:
            return "pineapple.normal"
        }
    }
    
    var transformedImage: String {
        switch self {
        case .apple:
            return "apple.trans"
        case .pineapple:
            return "pineapple.trans"
        }
    }
    
    var animationImages: [String] {
        switch self {
        case .apple:
            ["apple.1", "apple.2", "apple.3"]
        case .pineapple:
            ["pineapple.1", "pineapple.2", "pineapple.3"]
        }
    }
    
}
