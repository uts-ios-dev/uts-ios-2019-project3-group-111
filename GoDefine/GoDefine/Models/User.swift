//
//  User.swift
//  GoDefine
//
//  Created by Yang Qijun on 1/6/19.
//  Copyright © 2019 Yang Qijun. All rights reserved.
//

import Foundation

let defaults = UserDefaults.standard

class User {
    var name: String? {
        set(name) {
            defaults.set(name, forKey: "name")
        }
        get {
            return defaults.string(forKey: "name")
        }
    }
    
    var email: String {
        set(email) {
            defaults.set(email, forKey: "email")
        }
        get {
            return defaults.string(forKey: "email") ?? "user@example.com"
        }
    }
    
    var password: String {
        set(password) {
            defaults.set(password, forKey: "password")
        }
        get {
            return defaults.string(forKey: "password") ?? ""
        }
    }
    
    var dob: Date {
        set(dob) {
            defaults.set(dob, forKey: "dob")
        }
        get {
            return defaults.object(forKey: "dob") as! Date
        }
    }
    
    var gender: String {
        set(gender) {
            defaults.set(gender, forKey: "gender")
        }
        get {
            return defaults.string(forKey: "gender") ?? "Undefined"
        }
    }
    
    var weight: Int {
        set(weight) {
            defaults.set(weight, forKey: "weight")
        }
        get {
            return defaults.integer(forKey: "weight")
        }
    }
    
    var height: Int {
        set(height) {
            defaults.set(height, forKey: "height")
        }
        get {
            return defaults.integer(forKey: "height")
        }
    }
    
    var bfp: Float {
        set(bfp) {
            defaults.set(bfp, forKey: "bfp")
        }
        get {
            return defaults.float(forKey: "bfp")
        }
    }
    
    var workout: Float {
        set(workout) {
            defaults.set(workout, forKey: "workout")
        }
        get {
            return defaults.float(forKey: "workout")
        }
    }
    
    var standing: Float {
        set(standing) {
            defaults.set(standing, forKey: "standing")
        }
        get {
            return defaults.float(forKey: "standing")
        }
    }
    
    var walking: Float {
        set(walking) {
            defaults.set(walking, forKey: "walking")
        }
        get {
            return defaults.float(forKey: "walking")
        }
    }
    
    var climbing: Float {
        set(climbing) {
            defaults.set(climbing, forKey: "climbing")
        }
        get {
            return defaults.float(forKey: "climbing")
        }
    }
    
    var step: Float {
        set(step) {
            defaults.set(step, forKey: "step")
        }
        get {
            return defaults.float(forKey: "step")
        }
    }
    
    var total: Float {
        set(total) {
            defaults.set(total, forKey: "total")
        }
        get {
            return defaults.float(forKey: "total")
        }
    }
}
