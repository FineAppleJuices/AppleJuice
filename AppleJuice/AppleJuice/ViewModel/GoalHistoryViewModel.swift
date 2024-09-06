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
        statusList = coreDataManager.fetchAllEntity()
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
        statusList = coreDataManager.fetchAllEntity()
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
}
