//
//  TodayViewController.swift
//  GoDefine
//
//  Created by Yang Qijun on 26/5/19.
//  Copyright © 2019 Yang Qijun. All rights reserved.
//

import UIKit

class TodayViewController: UIViewController {
    
    @IBOutlet weak var greetLabel: UILabel!
    @IBOutlet weak var bubbleContainer: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var energyLabel: UILabel!
    
    var energy: Float {
        let group = DispatchGroup()
        group.enter()
        var energy: Float = 0.0
        var count = 0
        ActiveEnergyDataStore.shared.getTodayActiveEnergy { (steps) in
            energy = Float(steps)
            count += 1
            if count == 3{
                group.leave()
            }
        }
        return energy
    }
    
    let user = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authorizeHealthKit()
        
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        var progress: Float = 0.0
        if user.total != 0.0 {
            progress = energy / user.total
        }
        print(user.total)
        if progress < 0.5 {
            greetLabel.text = "Keep Fighting!"
        } else if progress < 0.75 {
            greetLabel.text = "Awosome Buddy!"
        } else {
            greetLabel.text = "Almost There!"
        }
        
        let bubbleRect = CGRect(
            center: CGPoint(
                x: bubbleContainer.frame.midX,
                y: bubbleContainer.frame.midY),
            size: CGSize(
                width: bubbleContainer.frame.width,
                height: bubbleContainer.frame.height))
        let bubbleView = BubbleView(frame: bubbleRect)
        bubbleView.assignHeightRatio = CGFloat(progress)
        view.insertSubview(bubbleView, at: 2)
        
        progressLabel.text = String(format: "%.0f", progress*100) + " %"
        energyLabel.text = String(format: "%.1f", energy)
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
