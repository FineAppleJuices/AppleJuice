//
//  MainViewModel.swift
//  WatchAppleJuice Watch App
//
//  Created by 이종선 on 6/29/24.
//

import Foundation

class MainViewModel: ObservableObject {
    @Published var stepCount = 0
    private var stepsManager = StepsManager()
    
    init() {
        self.stepCount = stepsManager.stepCount
    }
    
    var walkingLevel: WalkingLevel {
        switch stepCount {
        case ...999:
            return .level0
        case 1000...2999:
            return .level1000
        case 3000..<6999:
            return .level3000
        case 7000..<10000:
            return .level7000
        case 10000...:
            return .level10000
        default:
            return .level0
        }
    }
    
}
