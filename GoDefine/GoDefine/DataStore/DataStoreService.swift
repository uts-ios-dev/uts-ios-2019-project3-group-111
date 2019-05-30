//
//  DataStoreService.swift
//  GoDefine
//
//  Created by Tran Nhut Minh An Le on 29/5/19.
//  Copyright © 2019 Yang Qijun. All rights reserved.
//

import Foundation
import HealthKit

class HealthStoreServices{
    private var dataStore: HKHealthStore! = nil
    static let shared: HealthStoreServices = HealthStoreServices()
    
    private init() {
        dataStore  = HKHealthStore()
    }
    
    
    func getDatatBetweenDays(identifier: HKQuantityTypeIdentifier, unit: HKUnit,startDate: Date, endDate:Date, completion: @escaping(_ retrievedSteps: Double) -> Void){
        
        let cal = Calendar(identifier: Calendar.Identifier.gregorian)
        let startDate = cal.startOfDay(for: startDate)
        let endDate = Date()
        
        var total = 0.0
        var count = 0
        
        // Diff between start and end date
        let numberOfDays = cal.dateComponents([.day], from: startDate, to: cal.startOfDay(for: endDate))
        
        // Create the dispatch for receiving all the data before return the result
        let group = DispatchGroup()
        group.enter()
        
        // Get step count
        queryHealthCareData(identifier: identifier,unit: unit,  startDate: startDate, endDate: endDate, completion: { (data) in
            
            total = total + data
            if count == numberOfDays.day{
                group.leave()
            }
            count = count + 1

        }
        )
        group.wait()
        completion(total)
    }
    
    func getDatatBetweenDays(identifier: HKCategoryTypeIdentifier, unit: HKUnit,startDate: Date, endDate:Date, completion: @escaping(_ retrievedSteps: Double) -> Void){
        
        let cal = Calendar(identifier: Calendar.Identifier.gregorian)
        let startDate = cal.startOfDay(for: startDate)
        let endDate = Date()
        
        var total = 0.0
        var count = 0
        
        // Diff between start and end date
        let numberOfDays = cal.dateComponents([.day], from: startDate, to: cal.startOfDay(for: endDate))
        
        // Create the dispatch for receiving all the data before return the result
        let group = DispatchGroup()
        group.enter()
        
        // Get step count
        queryHealthCareData(identifier: identifier,unit: unit,  startDate: startDate, endDate: endDate, completion: { (data) in
            
            total = total + data
            if count == numberOfDays.day{
                group.leave()
            }
            count = count + 1
            
        }
        )
        group.wait()
        completion(total)
    }
    
    public func queryHealthCareData(identifier: HKQuantityTypeIdentifier, unit: HKUnit, startDate: Date, endDate:Date, completion: @escaping(_ retrievedSteps: Double) -> Void){
        
        // Innitisialse the period time for get the data
        let period = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: [.strictStartDate])
        
        // interval is 1 day
        var interval = DateComponents()
        interval.day = DateTime.oneDay.rawValue
        
        // start from midnight
        let calendar = Calendar.current
        let anchorDate = calendar.date(bySettingHour: 0, minute: 0, second: 0, of: Date())
        
        // prepare the query
        let query = HKStatisticsCollectionQuery(
            quantityType: HKSampleType.quantityType(forIdentifier: identifier)!,
            quantitySamplePredicate: period,
            options: .cumulativeSum,
            anchorDate: anchorDate!,
            intervalComponents: interval
        )
        
        // set up handler
        query.initialResultsHandler = { query, results, error in
            guard let results = results else {
                return
            }
            results.enumerateStatistics(from: startDate, to: endDate) {
                statistics, stop in
                
                if let quantity = statistics.sumQuantity() {
                    let steps = quantity.doubleValue(for: unit)
                    completion(steps)
                }
            }
        }
        dataStore.execute(query)
    }
    
    public func queryHealthCareData(identifier: HKCategoryTypeIdentifier, unit: HKUnit, startDate: Date, endDate:Date, completion: @escaping(_ retrievedSteps: Double) -> Void){
        
        // Innitisialse the period time for get the data
        let period = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: [.strictStartDate])
        
        // interval is 1 day
        var interval = DateComponents()
        interval.day = DateTime.oneDay.rawValue
        
        // start from midnight
        let calendar = Calendar.current
        let anchorDate = calendar.date(bySettingHour: 0, minute: 0, second: 0, of: Date())
        
        // prepare the query
        let query = HKActivitySummaryQuery(
            categoryType: HKSampleType.categoryType(forIdentifier: identifier)!,
            quantitySamplePredicate: period,
            options: .cumulativeSum,
            anchorDate: anchorDate!,
            intervalComponents: interval
        )
        
        // set up handler
        query.initialResultsHandler = { query, results, error in
            guard let results = results else {
                return
            }
            results.enumerateStatistics(from: startDate, to: endDate) {
                statistics, stop in
                
                if let quantity = statistics.sumQuantity() {
                    let steps = quantity.doubleValue(for: unit)
                    completion(steps)
                }
            }
        }
        dataStore.execute(query)
    }
}
