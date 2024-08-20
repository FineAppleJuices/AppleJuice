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

let sampleJuiceEntries: [JuiceEntry] = [
    JuiceEntry(date: Date(), steps: 3540),
    JuiceEntry(date: Calendar.current.date(byAdding: .day, value: -1, to: Date())!, steps: 4876),
    JuiceEntry(date: Calendar.current.date(byAdding: .day, value: -2, to: Date())!, steps: 6578),
    JuiceEntry(date: Calendar.current.date(byAdding: .day, value: -3, to: Date())!, steps: 7321),
    JuiceEntry(date: Calendar.current.date(byAdding: .day, value: -4, to: Date())!, steps: 8456),
    JuiceEntry(date: Calendar.current.date(byAdding: .day, value: -5, to: Date())!, steps: 5123),
    JuiceEntry(date: Calendar.current.date(byAdding: .day, value: -6, to: Date())!, steps: 3789),
    JuiceEntry(date: Calendar.current.date(byAdding: .day, value: -7, to: Date())!, steps: 9201),
    JuiceEntry(date: Calendar.current.date(byAdding: .day, value: -8, to: Date())!, steps: 6034),
    JuiceEntry(date: Calendar.current.date(byAdding: .day, value: -9, to: Date())!, steps: 4567),
    JuiceEntry(date: Calendar.current.date(byAdding: .day, value: -10, to: Date())!, steps: 7890),
    JuiceEntry(date: Calendar.current.date(byAdding: .day, value: -11, to: Date())!, steps: 9004),
    JuiceEntry(date: Calendar.current.date(byAdding: .day, value: -12, to: Date())!, steps: 5123),
    JuiceEntry(date: Calendar.current.date(byAdding: .day, value: -13, to: Date())!, steps: 6237),
    JuiceEntry(date: Calendar.current.date(byAdding: .day, value: -14, to: Date())!, steps: 7864),
    JuiceEntry(date: Calendar.current.date(byAdding: .day, value: -15, to: Date())!, steps: 4290),
    JuiceEntry(date: Calendar.current.date(byAdding: .day, value: -16, to: Date())!, steps: 8356),
    JuiceEntry(date: Calendar.current.date(byAdding: .day, value: -17, to: Date())!, steps: 6782),
    JuiceEntry(date: Calendar.current.date(byAdding: .day, value: -18, to: Date())!, steps: 8930),
    JuiceEntry(date: Calendar.current.date(byAdding: .day, value: -19, to: Date())!, steps: 4032),
    JuiceEntry(date: Calendar.current.date(byAdding: .day, value: -20, to: Date())!, steps: 7154),
    JuiceEntry(date: Calendar.current.date(byAdding: .day, value: -21, to: Date())!, steps: 6023),
    JuiceEntry(date: Calendar.current.date(byAdding: .day, value: -22, to: Date())!, steps: 7890),
    JuiceEntry(date: Calendar.current.date(byAdding: .day, value: -23, to: Date())!, steps: 5689),
    JuiceEntry(date: Calendar.current.date(byAdding: .day, value: -24, to: Date())!, steps: 9234),
    JuiceEntry(date: Calendar.current.date(byAdding: .day, value: -25, to: Date())!, steps: 8345),
    JuiceEntry(date: Calendar.current.date(byAdding: .day, value: -26, to: Date())!, steps: 4390),
    JuiceEntry(date: Calendar.current.date(byAdding: .day, value: -27, to: Date())!, steps: 6703),
    JuiceEntry(date: Calendar.current.date(byAdding: .day, value: -28, to: Date())!, steps: 7654),
    JuiceEntry(date: Calendar.current.date(byAdding: .day, value: -29, to: Date())!, steps: 9801)
]

class GoalHistoryViewModel: ObservableObject {
    
    @Published var statusList: [DailyStatus] = []
    @Published var juiceEntries: [JuiceEntry] = []
    let coreDataManager = CoreDataManager.shared
    private var healthStore = HKHealthStore()

//    init() {
//        statusList = coreDataManager.fetchAllEntity()
//        requestHealthAuthorization()
//    }
    
    init(useSampleData: Bool = false) {
        statusList = coreDataManager.fetchAllEntity()
        requestHealthAuthorization()
        
        // 샘플 데이터를 사용할지 결정
        if useSampleData {
            juiceEntries = sampleJuiceEntries
        }
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
