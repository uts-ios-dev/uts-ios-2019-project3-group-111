//
//  HealthKitSetupAssistant.swift
//  GoDefine
//
//  Created by Tran Nhut Minh An Le on 27/5/19.
//  Copyright © 2019 Yang Qijun. All rights reserved.
//

import Foundation
import HealthKit

class HealthKitSetupAssistant {
    
    private enum HealthkitSetupError: Error {
        case notAvailableOnDevice
        case dataTypeNotAvailable
    }
    
    class func authorizeHealthKit(completion: @escaping (Bool, Error?) -> Swift.Void) {
        
        //1. Check to see if HealthKit Is Available on this device
        guard HKHealthStore.isHealthDataAvailable() else {
            completion(false, HealthkitSetupError.notAvailableOnDevice)
            return
        }
        let _: Set<HKObjectType> = [
            HKObjectType.activitySummaryType()
        ]
        
        //2. Prepare the data types that will interact with HealthKit
        guard   let dateOfBirth = HKObjectType.characteristicType(forIdentifier: .dateOfBirth),
            let bloodType = HKObjectType.characteristicType(forIdentifier: .bloodType),
            let biologicalSex = HKObjectType.characteristicType(forIdentifier: .biologicalSex),
            let bodyMassIndex = HKObjectType.quantityType(forIdentifier: .bodyMassIndex),
            let height = HKObjectType.quantityType(forIdentifier: .height),
            let bodyMass = HKObjectType.quantityType(forIdentifier: .bodyMass),
            let steptCount = HKObjectType.quantityType(forIdentifier: .stepCount),
            let walkingDistance = HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning),
            let appleExerciseTime = HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.appleExerciseTime),
            let flightsClimbed = HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.flightsClimbed),
            let appleStandHour = HKObjectType.categoryType(forIdentifier: HKCategoryTypeIdentifier.appleStandHour),
            let activeEnergy = HKObjectType.quantityType(forIdentifier: .activeEnergyBurned),
            let appleExcerise = HKObjectType.quantityType(forIdentifier: .appleExerciseTime)

            else {
                
                completion(false, HealthkitSetupError.dataTypeNotAvailable)
                return
        }
        
        //3. Prepare a list of types you want HealthKit to read and write
        let healthKitTypesToWrite: Set<HKSampleType> = [bodyMassIndex,
                                                        activeEnergy,
                                                        HKObjectType.workoutType()]
        
        let healthKitTypesToRead: Set<HKObjectType> = [dateOfBirth,
                                                       bloodType,
                                                       biologicalSex,
                                                       bodyMassIndex,
                                                       height,
                                                       bodyMass,
                                                       steptCount,
                                                       walkingDistance,
                                                       appleExerciseTime,
                                                       appleStandHour,
                                                       activeEnergy,
                                                       flightsClimbed,
                                                       appleExcerise,
                                                       HKObjectType.activitySummaryType(),
                                                       HKObjectType.workoutType()]
        
        //4. Request Authorization
        HKHealthStore().requestAuthorization(toShare: healthKitTypesToWrite,
                                             read: healthKitTypesToRead) { (success, error) in
                                                completion(success, error)
        }
    }
}
