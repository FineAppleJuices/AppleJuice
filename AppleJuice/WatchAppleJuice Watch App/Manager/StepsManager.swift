//
//  StepsManager.swift
//  AppleJuice
//
//  Created by 이종선 on 6/28/24.
//
import Foundation
import HealthKit

class StepsManager: ObservableObject {
    @Published var stepCount: Int = 10000

    private var healthStore: HKHealthStore
    private var query: HKObserverQuery?

    init() {
        healthStore = HKHealthStore()
        requestAuthorization()
    }

    func requestAuthorization() {
        let stepType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
        let typesToShare: Set = [stepType]
        let typesToRead: Set = [stepType]

        healthStore.requestAuthorization(toShare: typesToShare, read: typesToRead) { (success, error) in
            if success {
                self.startStepCountQuery()
            } else {
                print("HealthKit authorization failed: \(String(describing: error))")
            }
        }
    }

    func startStepCountQuery() {
        let stepType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
        query = HKObserverQuery(sampleType: stepType, predicate: nil) { [weak self] query, completionHandler, error in
            if let error = error {
                print("ObserverQuery error: \(error.localizedDescription)")
                return
            }
            self?.fetchStepCount()
            completionHandler()
        }
        healthStore.execute(query!)
    }

    func fetchStepCount() {
        let stepType = HKQuantityType.quantityType(forIdentifier: .stepCount)!

        //query 보낼 시간대에 대한 변수
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        let endOfDay = Calendar.current.date(byAdding: .day, value: 1, to: startOfDay)!
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: endOfDay, options: .strictStartDate)

        let query = HKStatisticsQuery(quantityType: stepType, quantitySamplePredicate: predicate, options: .cumulativeSum) { [weak self] _, result, error in
            guard let self = self else { return }

            if let error = error {
                print("StatisticsQuery error: \(error.localizedDescription)")
                return
            }

            if let result = result, let sum = result.sumQuantity() {
                DispatchQueue.main.async {
                    self.stepCount = Int(sum.doubleValue(for: HKUnit.count()))
                }
            }
        }
        healthStore.execute(query)
    }
}
