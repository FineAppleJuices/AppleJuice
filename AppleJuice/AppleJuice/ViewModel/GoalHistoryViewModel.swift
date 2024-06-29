//
//  GoalHistoryViewModel.swift
//  AppleJuice
//
//  Created by 이종선 on 6/29/24.
//

import SwiftUI


class GoalHistoryViewModel: ObservableObject {
    
    @Published var statusList: [DailyStatus] = []
    let coreDataManager = CoreDataManager.shared
    
    init(){
        statusList = coreDataManager.fetchAllEntity()
    }
}
