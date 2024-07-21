//
//  GoalHistoryViewModel.swift
//  AppleJuice
//
//  Created by 이종선 on 6/29/24.
//
import SwiftUI
import HealthKit


struct JuiceEntry: Identifiable, Equatable {
    let id = UUID()
    let date: Date
    let steps: Int

    static func == (lhs: JuiceEntry, rhs: JuiceEntry) -> Bool {
        return lhs.id == rhs.id
    }
}

class GoalHistoryViewModel: ObservableObject {
    
    @Published var statusList: [DailyStatus] = []
    @Published var juiceEntries: [JuiceEntry] = []
    let coreDataManager = CoreDataManager.shared
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

    func addJuiceEntry(date: Date, steps: Int) {
        let newEntry = JuiceEntry(date: date, steps: steps)
        juiceEntries.append(newEntry)
    }

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
