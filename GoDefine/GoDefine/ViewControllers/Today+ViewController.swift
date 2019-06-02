//
//  TodayViewController.swift
//  GoDefine
//
//  Created by Yang Qijun on 26/5/19.
//  Copyright © 2019 Yang Qijun. All rights reserved.
//

import UIKit

class TodayViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authorizeHealthKit()
        
        // Do any additional setup after loading the view.
        let bubbleView = BubbleView(frame: CGRect(x: view.frame.width/2-125, y: view.frame.height/2-125, width: 250, height: 250))
        view.addSubview(bubbleView)
        
    }
    
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
