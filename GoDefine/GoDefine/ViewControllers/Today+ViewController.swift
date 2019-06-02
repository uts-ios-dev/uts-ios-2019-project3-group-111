//
//  TodayViewController.swift
//  GoDefine
//
//  Created by Yang Qijun on 26/5/19.
//  Copyright © 2019 Yang Qijun. All rights reserved.
//

import UIKit

class TodayViewController: UIViewController {
    
//    @IBOutlet weak var todayStepCount: UILabel!
    @IBOutlet weak var todayStepCount: UILabel!
    @IBOutlet weak var lastRecentWeekStepCountLbl: UILabel!
    @IBOutlet weak var todayWalkingDistanceLbl: UILabel!
    @IBOutlet weak var lastWeekWalkingDistance: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        authorizeHealthKit()
        // Do any additional setup after loading the view.
        
    }
    
//    private func loadTodayWalkingDistance(){
//        WalkingDataStore.shared.getTodayWalkingDistance { (distance) in
//            DispatchQueue.main.async {
//                self.todayWalkingDistanceLbl.text = String("\(distance)")
//            }
//        }
//    }
//
//    private func loadTheLastRecentWeekWalkingDistance(){
//        WalkingDataStore.shared.getTheLastRecentWeekWalkingDistance(completion: { (steps) in
//            DispatchQueue.main.async {
//                self.lastWeekWalkingDistance.text = String("\(steps)")
//            }
//        })
//    }
//
//    private func loadTodaySteps(){
//        ActiveEnergyDataStore.shared.getTodayActiveEnergy(completion: { (steps) in
//            DispatchQueue.main.async {
//                self.todayStepCount.text = String("\(steps)")
//            }
//        })
//    }
//
//    private func loadTheLastRecentWeekStepCount(){
//    SteptCountDataStore.shared.getTheLastRecentWeekStepCount(completion: { (steps) in
//                DispatchQueue.main.async {
//                    self.lastRecentWeekStepCountLbl.text = String("\(steps)")
//                }
//
//        })
//    }
//
    private func authorizeHealthKit() {

        HealthKitSetupAssistant.authorizeHealthKit { (authorized, error) in

            guard authorized else {

                let baseMessage = "HealthKit Authorization Failed"

                if let error = error {
                    print("\(baseMessage). Reason: \(error.localizedDescription)")
                } else {
                    print(baseMessage)
                }
                return
            }
            print("HealthKit Successfully Authorized.")
        }

    }
}
