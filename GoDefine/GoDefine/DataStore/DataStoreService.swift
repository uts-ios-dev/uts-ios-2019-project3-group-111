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
        
        // Create the dispatch for receiving all the data before return the result
        let group = DispatchGroup()
        group.enter()
        
        // Get step count
        queryHealthCareData(identifier: identifier,unit: unit,  startDate: startDate, endDate: endDate, completion: { (data,totalNumberOfRecord) in
            
            total = total + data
            count = count + 1
            
            if count == totalNumberOfRecord || totalNumberOfRecord == 0{
                group.leave()
            }

        }
        )
        group.wait()
        completion(total)
    }
    
    func getDatatBetweenDays(identifier: String,startDate: Date, endDate:Date, completion: @escaping(_ retrievedSteps: Double ) -> Void){
        
        let cal = Calendar(identifier: Calendar.Identifier.gregorian)
        let startDate = cal.startOfDay(for: startDate)
        let endDate = Date()
        
        var total = 0.0
        var count = 0
        
        // Create the dispatch for receiving all the data before return the result
        let group = DispatchGroup()
        group.enter()
        
        // Get step count
        queryHealthCareData(identifier: identifier, startDate: startDate, endDate: endDate, completion: { (data, totalNumberOfRecord) in
            
            total = total + data
            count = count + 1
            if count == totalNumberOfRecord || totalNumberOfRecord == 0{
                group.leave()
            }
        }
        )
        group.wait()
        completion(total)
    }
    
    public func queryHealthCareData(identifier: HKQuantityTypeIdentifier, unit: HKUnit, startDate: Date, endDate:Date, completion: @escaping(_ retrievedSteps: Double, _ totalNumberOfRecord: Int) -> Void){
        
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
                completion(0.0, 0)
                return
            }
            let totalNumberOfRecord = results.statistics().count
            
            if totalNumberOfRecord > 0{
                results.enumerateStatistics(from: startDate, to: endDate) {
                    statistics, stop in
                    
                    if let quantity = statistics.sumQuantity() {
                        let data = quantity.doubleValue(for: unit)
                        completion(data, totalNumberOfRecord)
                    }
                }
            }else{
                completion(0.0, 0)
            }
            
        }
        
        
        
        dataStore.execute(query)
    }
    
    public func queryHealthCareData(identifier: String, startDate: Date, endDate:Date, completion: @escaping(_ retrievedSteps: Double, _ totalNumberOfRecord: Int) -> Void){

        
        // Create the date components for the predicate
        guard let calendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian) else {
            fatalError("*** This should never fail. ***")
        }

        let units: NSCalendar.Unit = [.day, .month, .year, .era]

        var startDateComponents = calendar.components(units, from: startDate)
        startDateComponents.calendar = calendar as Calendar

        var endDateComponents = calendar.components(units, from: endDate as Date)
        endDateComponents.calendar = calendar as Calendar


//         Create the predicate for the query
        let summariesWithinRange =  HKQuery.predicate(forActivitySummariesBetweenStart: startDateComponents, end: endDateComponents)

        // Build the query
        let query = HKActivitySummaryQuery(predicate: summariesWithinRange) { (query, summaries, error) -> Void in
            guard let activitySummaries = summaries else {
                guard error != nil else {
                    fatalError("*** Did not return a valid error object. ***")
                }
                // Handle the error here...
                completion(0.0, 0)
                return
            }
            if activitySummaries.count > 0{
                for thisSummary in activitySummaries {
                    var data = 0.0
                    switch identifier {
                    case "appleStandHour":
                        let standUnit = HKUnit.count()
                        data = thisSummary.appleStandHours.doubleValue(for: standUnit)
                    case "appleExcersise":
                        let standUnit = HKUnit.hour()
                        data = thisSummary.appleExerciseTime.doubleValue(for: standUnit)
                    default:
                        let standUnit = HKUnit.count()
                        data = thisSummary.appleStandHours.doubleValue(for: standUnit)
                    }
                    completion(data, activitySummaries.count)
                }
            }else{
                completion(0.0, 0)
            }
            
        }

        dataStore.execute(query)

       
        
        
        
    }
}
