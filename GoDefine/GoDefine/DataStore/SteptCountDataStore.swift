//
//  WorkoutDataStore.swift
//  GoDefine
//
//  Created by Tran Nhut Minh An Le on 27/5/19.
//  Copyright © 2019 Yang Qijun. All rights reserved.
//

import Foundation
import HealthKit


class SteptCountDataStore {
    
    static let shared: SteptCountDataStore = SteptCountDataStore()
    
    func save(prancerciseWorkout: Workout,
              completion: @escaping ((Bool, Error?) -> Swift.Void)) {
        
    }
    
    func getTodayStepCount(completion: @escaping (_ stepRetrieved: Double) -> Void) {
        
        //        let startDate = Date().addingTimeInterval(-3600 * 24 * 7)
        let cal = Calendar(identifier: Calendar.Identifier.gregorian)
        let startDate = cal.startOfDay(for: Date())
        let endDate = Date()
        HealthStoreServices.shared.getDatatBetweenDays(identifier: .stepCount, unit: HKUnit.count(), startDate: startDate, endDate: endDate, completion: {
            (steps) in completion(steps)
            }
        )

    }
    
    func getTheLastRecentWeekStepCount(completion: @escaping (_ stepRetrieve: Double) -> Void){
        
        // Get the last 7 day from today
        let startDate = Date().addingTimeInterval(TimeInterval(-1 * DateTime.hourInSecond.rawValue * DateTime.hourInDay.rawValue * DateTime.numDayInWeek.rawValue))
        let endDate = Date()
        
        HealthStoreServices.shared.getDatatBetweenDays(identifier: .stepCount, unit: HKUnit.count(), startDate: startDate, endDate: endDate, completion: {
            (steps) in completion(steps)
            }
        )
    }
    
    func getTheLastRecentMonth(completion: @escaping (_ stepRetrieve: Double) -> Void){
        
        // Get the last 7 day from today
        let startDate = Date().addingTimeInterval(TimeInterval(-1 * DateTime.hourInSecond.rawValue * DateTime.hourInDay.rawValue * DateTime.numDaysInMonth.rawValue))
        let endDate = Date()
        HealthStoreServices.shared.getDatatBetweenDays(identifier: .stepCount, unit: HKUnit.count(), startDate: startDate, endDate: endDate, completion: {
            (steps) in completion(steps)
        }
        )
    }
    
    
}
