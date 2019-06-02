//
//  StandHourDataStore.swift
//  GoDefine
//
//  Created by Tran Nhut Minh An Le on 30/5/19.
//  Copyright © 2019 Yang Qijun. All rights reserved.
//

import Foundation
import HealthKit

class StandHourDataStore{
    static let shared: StandHourDataStore = StandHourDataStore()
    
    func getTodayStandHour(completion: @escaping (_ stepRetrieved: Double) -> Void) {
        
        //        let startDate = Date().addingTimeInterval(-3600 * 24 * 7)
        let cal = Calendar(identifier: Calendar.Identifier.gregorian)
        let startDate = cal.startOfDay(for: Date())
        let endDate = Date()
        HealthStoreServices.shared.getDatatBetweenDays(identifier: "appleStandHour", startDate: startDate, endDate: endDate, completion: completion)
    }
    
    func getTheLastRecentWeekStandHour(completion: @escaping (_ stepRetrieve: Double) -> Void){
        
        // Get the last 7 day from today
        let startDate = Date().addingTimeInterval(TimeInterval(-1 * DateTime.hourInSecond.rawValue * DateTime.hourInDay.rawValue * DateTime.numDayInWeek.rawValue))
        let endDate = Date()
        
        HealthStoreServices.shared.getDatatBetweenDays(identifier: "appleStandHour",  startDate: startDate, endDate: endDate, completion: completion)
    }
    
    func getTheLastRecentMonthStandHour(completion: @escaping (_ stepRetrieve: Double) -> Void){
        
        // Get the last 7 day from today
        let startDate = Date().addingTimeInterval(TimeInterval(-1 * DateTime.hourInSecond.rawValue * DateTime.hourInDay.rawValue * DateTime.numDaysInMonth.rawValue))
        let endDate = Date()
        
        HealthStoreServices.shared.getDatatBetweenDays(identifier: "appleStandHour", startDate: startDate, endDate: endDate, completion: completion)
    }
}
