//
//  WorkoutDataStore.swift
//  GoDefine
//
//  Created by Tran Nhut Minh An Le on 27/5/19.
//  Copyright © 2019 Yang Qijun. All rights reserved.
//

import Foundation
import HealthKit
class WorkoutDataStore {
    
    class func save(prancerciseWorkout: Workout,
                    completion: @escaping ((Bool, Error?) -> Swift.Void)) {
        
    }
    
    class func getMostRecentStep(completion: @escaping (_ stepRetrieved: Double) -> Void) {
        let healthStore = HKHealthStore()

        let startDate = Date().addingTimeInterval(-3600 * 24 * 7)
        let endDate = Date()
        
        let predicate = HKQuery.predicateForSamples(
            withStart: startDate,
            end: endDate,
            options: [.strictStartDate, .strictEndDate]
        )
        
        // interval is 1 day
        var interval = DateComponents()
        interval.day = 1
        
        // start from midnight
        let calendar = Calendar.current
        let anchorDate = calendar.date(bySettingHour: 12, minute: 0, second: 0, of: Date())
        
        let query = HKStatisticsCollectionQuery(
            quantityType: HKSampleType.quantityType(forIdentifier: .stepCount)!,
            quantitySamplePredicate: predicate,
            options: .cumulativeSum,
            anchorDate: anchorDate!,
            intervalComponents: interval
        )
        
        query.initialResultsHandler = { query, results, error in
            guard let results = results else {
                return
            }
            
            results.enumerateStatistics(
                from: startDate,
                to: endDate,
                with: { (result, stop) in
                    let totalStepForADay = result.sumQuantity()?.doubleValue(for: HKUnit.count()) ?? 0
                    print(totalStepForADay)
            }
            )
        }
        
        healthStore.execute(query)
        
    }
    
    
}
