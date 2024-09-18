//
//  GoalHistoryViewModel.swift
//  AppleJuice
//
//  Created by 이종선 on 6/29/24.
//

import SwiftUI
import HealthKit
    
class GoalHistoryViewModel: ObservableObject {
    let coreDataManager = CoreDataManager.shared

    @Published var statusList: [DailyStatus] = []
    
    private var healthStore = HKHealthStore()

    init() {
        //초기화 할때 한번씩 걸음수 갱신하기
        refreshStepCounts()
        statusList = coreDataManager.fetchEntities()
        requestHealthAuthorization()
    }
        
    private func requestHealthAuthorization() {
        guard HKHealthStore.isHealthDataAvailable() else { return }
        let stepType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
        healthStore.requestAuthorization(toShare: nil, read: [stepType]) { success, error in
            if success {
                print("HealthKit authorization successful.")
            } else if let error = error {
                print("HealthKit authorization failed: \(error.localizedDescription)")
            }
        }
    }

    // CoreDate 에 새로운 데이터 추가하기
    func addJuiceEntry(date: Date, steps: Int) {
        coreDataManager.createEntity(dailyStatus: DailyStatus(id: UUID().uuidString, date: date, steps: steps))
        //리스트 갱신하기
        statusList = coreDataManager.fetchEntities()
    }

    // HealthKit에 해당 날짜로 쿼리를 보내 걸음 수를 받아오기
    func fetchSteps(for date: Date, completion: @escaping (Int) -> Void) {
        let stepType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
        let startDate = Calendar.current.startOfDay(for: date)
        let endDate = Calendar.current.date(byAdding: .day, value: 1, to: startDate)!

        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)
        let query = HKStatisticsQuery(quantityType: stepType, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, _ in
            var steps = 0
            if let sum = result?.sumQuantity() {
                steps = Int(sum.doubleValue(for: HKUnit.count()))
            }
            DispatchQueue.main.async {
                completion(steps)
            }
        }
        healthStore.execute(query)
    }
    
    //앱을 기동한 날짜와 마지막으로 저장된 접속 날짜 사이에 있는 데이터들의 헬스킷을 한번 더 갱신
    private func refreshStepCounts() {
        let from: Date = getLastLoginDate() ?? Date()
        let to: Date = Date()

        let listToRefresh: [DailyStatus] = coreDataManager.fetchEntities(startDate: from, endDate: to)
        
        for data in listToRefresh {
            var data = data
            // 걸음 수를 비동기적으로 가져와서 데이터를 갱신
            fetchSteps(for: data.date) { steps in
                data.steps = steps
                // 데이터를 업데이트한 후에 CoreData에 저장
                self.coreDataManager.saveContext()
            }
        }
    }
}
