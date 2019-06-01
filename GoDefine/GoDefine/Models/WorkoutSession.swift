//
//  WorkoutSession.swift
//  GoDefine
//
//  Created by Tran Nhut Minh An Le on 27/5/19.
//  Copyright © 2019 Yang Qijun. All rights reserved.
//

import Foundation

enum WorkoutSessionState {
    case notStarted
    case active
    case finished
}

class WorkoutSession {
    
    private (set) var startDate: Date!
    private (set) var endDate: Date!
    
    var state: WorkoutSessionState = .notStarted
    
    func start() {
        startDate = Date()
        state = .active
    }
    
    func end() {
        endDate = Date()
        state = .finished
    }
    
    func clear() {
        startDate = nil
        endDate = nil
        state = .notStarted
    }
    
    var completeWorkout: Workout? {
        get {
            guard state == .finished,
                let startDate = startDate,
                let endDate = endDate else {
                    return nil
            }
            return Workout(start: startDate, end: endDate)
        }
    }
}

