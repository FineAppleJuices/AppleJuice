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
        
}
