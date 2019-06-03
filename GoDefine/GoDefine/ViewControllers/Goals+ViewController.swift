//
//  GoalsViewController.swift
//  GoDefine
//
//  Created by Yang Qijun on 26/5/19.
//  Copyright © 2019 Yang Qijun. All rights reserved.
//

import UIKit
import fluid_slider

class GoalsViewController: UIViewController {
    
    let user = User()
    var previousStanding: CGFloat = 0.0
    var previousWorkout: CGFloat = 0.0
    var previousWalking: CGFloat = 0.0
    var previousClimging: CGFloat = 0.0
    var previousStep: CGFloat = 0.0

    @IBOutlet var totalCalLabel: UILabel!
    @IBOutlet var totalSlider: Slider!
    @IBOutlet var workoutHrsLabel: UILabel!
    @IBOutlet var workOutSlider: Slider!
    @IBOutlet var standingHrsLabel: UILabel!
    @IBOutlet var standingSlider: Slider!
    @IBOutlet var stepLabel: UILabel!
    @IBOutlet var stepSlider: Slider!
    @IBOutlet var walkingKmLabel: UILabel!
    @IBOutlet var walkingSlider: Slider!
    @IBOutlet var climbingFlrLabel: UILabel!
    @IBOutlet var climbingSlider: Slider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        populateLabels()

        // Do any additional setup after loading the view.
        let labelTextAttributes: [NSAttributedString.Key : Any] = [.font: UIFont.systemFont(ofSize: 10, weight: .medium), .foregroundColor: UIColor.white]
        totalSlider.attributedTextForFraction = { fraction in
            let formatter = NumberFormatter()
            formatter.maximumIntegerDigits = 3
            formatter.maximumFractionDigits = 0
            let string = formatter.string(from: (fraction * 4000) as NSNumber) ?? ""
            return NSAttributedString(string: string, attributes: [.font: UIFont.systemFont(ofSize: 10, weight: .medium), .foregroundColor: UIColor.white])
        }
        totalSlider.setMinimumLabelAttributedText(NSAttributedString(string: "0", attributes: labelTextAttributes))
        totalSlider.setMaximumLabelAttributedText(NSAttributedString(string: "4000", attributes: labelTextAttributes))
        totalSlider.fraction = 0.5
        totalSlider.shadowOffset = CGSize(width: 0, height: 10)
        totalSlider.shadowBlur = 5
//        totalSlider.shadowColor = UIColor(white: 0, alpha: 0.1)
        totalSlider.contentViewColor = UIColor(red: 78/255.0, green: 77/255.0, blue: 224/255.0, alpha: 1)
        totalSlider.valueViewColor = .white
        totalSlider.didBeginTracking = { [weak self] _ in
            self?.setLabelHidden(true, animated: true)
        }
        totalSlider.didEndTracking = { [weak self] _ in
            self?.setLabelHidden(false, animated: true)
            self?.totalCalLabel.text = String(format: "%.1f", Float((self?.totalSlider.fraction)! * 4000))
            self?.workOutSlider.fraction = 0.80*(self?.totalSlider.fraction)!*0.6
            self?.standingSlider.fraction = 0.90*(self?.totalSlider.fraction)!*0.6
            self?.walkingSlider.fraction = 0.80*(self?.totalSlider.fraction)!*0.6
            self?.climbingSlider.fraction = 0.75*(self?.totalSlider.fraction)!*0.6
            self?.stepSlider.fraction = 0.85*(self?.totalSlider.fraction)!*0.6
            self?.updateLabels()
        }
        
        // workout goal setting slider
        workOutSlider.attributedTextForFraction = { fraction in
            let formatter = NumberFormatter()
            formatter.maximumIntegerDigits = 3
            formatter.maximumFractionDigits = 0
            let string = formatter.string(from: (fraction * 8) as NSNumber) ?? ""
            return NSAttributedString(string: string, attributes: [.font: UIFont.systemFont(ofSize: 10, weight: .medium), .foregroundColor: UIColor.white])
        }
        workOutSlider.setMinimumLabelAttributedText(NSAttributedString(string: "0", attributes: labelTextAttributes))
        workOutSlider.setMaximumLabelAttributedText(NSAttributedString(string: "8", attributes: labelTextAttributes))
        workOutSlider.fraction = 0.5
        workOutSlider.shadowOffset = CGSize(width: 0, height: 10)
        workOutSlider.shadowBlur = 5
//        workOutSlider.shadowColor = UIColor(white: 0, alpha: 0.1)
        workOutSlider.contentViewColor = UIColor(red: 0/255.0, green: 185/255.0, blue: 2/255.0, alpha: 1)
        workOutSlider.valueViewColor = .white
        workOutSlider.didBeginTracking = { [weak self] _ in
            self?.setLabelHidden(true, animated: true)
            self?.previousWorkout = (self?.workOutSlider.fraction)!
        }
        workOutSlider.didEndTracking = { [weak self] _ in
            self?.setLabelHidden(false, animated: true)
            let delta = (self?.workOutSlider.fraction)! - self!.previousWorkout
            self?.workoutHrsLabel.text = String(format: "%.0f", Float((self?.workOutSlider.fraction)! * 8))
            self?.totalSlider.fraction += 0.8 * delta / 5
            self?.updateLabels()
        }
        
        // standing goal setting slider
        standingSlider.attributedTextForFraction = { fraction in
            let formatter = NumberFormatter()
            formatter.maximumIntegerDigits = 3
            formatter.maximumFractionDigits = 0
            let string = formatter.string(from: (fraction * 10) as NSNumber) ?? ""
            return NSAttributedString(string: string, attributes: [.font: UIFont.systemFont(ofSize: 10, weight: .medium), .foregroundColor: UIColor.white])
        }
        standingSlider.setMinimumLabelAttributedText(NSAttributedString(string: "0", attributes: labelTextAttributes))
        standingSlider.setMaximumLabelAttributedText(NSAttributedString(string: "10", attributes: labelTextAttributes))
        standingSlider.fraction = 0.5
        standingSlider.shadowOffset = CGSize(width: 0, height: 10)
        standingSlider.shadowBlur = 5
//        standingSlider.shadowColor = UIColor(white: 0, alpha: 0.1)
        standingSlider.contentViewColor = UIColor(red: 137/255.0, green: 95/255.0, blue: 255/255.0, alpha: 1)
        standingSlider.valueViewColor = .white
        standingSlider.didBeginTracking = { [weak self] _ in
            self?.setLabelHidden(true, animated: true)
            self?.previousStanding = (self?.standingSlider.fraction)!
        }
        standingSlider.didEndTracking = { [weak self] _ in
            self?.setLabelHidden(false, animated: true)
            let delta = (self?.standingSlider.fraction)! - self!.previousStanding
            self?.standingHrsLabel.text = String(format: "%.0f", Float((self?.standingSlider.fraction)! * 10))
            self?.totalSlider.fraction += 0.9 * delta / 5
            self?.updateLabels()
        }
        
        // walking goal setting slider
        walkingSlider.attributedTextForFraction = { fraction in
            let formatter = NumberFormatter()
            formatter.maximumIntegerDigits = 3
            formatter.maximumFractionDigits = 0
            let string = formatter.string(from: (fraction * 20) as NSNumber) ?? ""
            return NSAttributedString(string: string, attributes: [.font: UIFont.systemFont(ofSize: 10, weight: .medium), .foregroundColor: UIColor.white])
        }
        walkingSlider.setMinimumLabelAttributedText(NSAttributedString(string: "0", attributes: labelTextAttributes))
        walkingSlider.setMaximumLabelAttributedText(NSAttributedString(string: "20", attributes: labelTextAttributes))
        walkingSlider.fraction = 0.5
        walkingSlider.shadowOffset = CGSize(width: 0, height: 10)
        walkingSlider.shadowBlur = 5
//        walkingSlider.shadowColor = UIColor(white: 0, alpha: 0.1)
        walkingSlider.contentViewColor = UIColor(red: 53/255.0, green: 172/255.0, blue: 255/255.0, alpha: 1)
        walkingSlider.valueViewColor = .white
        walkingSlider.didBeginTracking = { [weak self] _ in
            self?.setLabelHidden(true, animated: true)
            self?.previousWalking = (self?.walkingSlider.fraction)!
        }
        walkingSlider.didEndTracking = { [weak self] _ in
            self?.setLabelHidden(false, animated: true)
            let delta = (self?.walkingSlider.fraction)! - self!.previousWalking
            self?.walkingKmLabel.text = String(format: "%.1f", Float((self?.walkingSlider.fraction)! * 20))
            self?.totalSlider.fraction += 0.8 * delta / 5
            self?.updateLabels()
        }
        
        // climbing goal setting slider
        climbingSlider.attributedTextForFraction = { fraction in
            let formatter = NumberFormatter()
            formatter.maximumIntegerDigits = 3
            formatter.maximumFractionDigits = 0
            let string = formatter.string(from: (fraction * 50) as NSNumber) ?? ""
            return NSAttributedString(string: string, attributes: [.font: UIFont.systemFont(ofSize: 10, weight: .medium), .foregroundColor: UIColor.white])
        }
        climbingSlider.setMinimumLabelAttributedText(NSAttributedString(string: "0", attributes: labelTextAttributes))
        climbingSlider.setMaximumLabelAttributedText(NSAttributedString(string: "50", attributes: labelTextAttributes))
        climbingSlider.fraction = 0.5
        climbingSlider.shadowOffset = CGSize(width: 0, height: 10)
        climbingSlider.shadowBlur = 5
//        climbingSlider.shadowColor = UIColor(white: 0, alpha: 0.1)
        climbingSlider.contentViewColor = UIColor(red: 181/255.0, green: 0/255.0, blue: 255/255.0, alpha: 1)
        climbingSlider.valueViewColor = .white
        climbingSlider.didBeginTracking = { [weak self] _ in
            self?.setLabelHidden(true, animated: true)
            self?.previousClimging = (self?.climbingSlider.fraction)!
        }
        climbingSlider.didEndTracking = { [weak self] _ in
            self?.setLabelHidden(false, animated: true)
            let delta = (self?.climbingSlider.fraction)! - self!.previousClimging
            self?.climbingFlrLabel.text = String(format: "%.1f", Float((self?.climbingSlider.fraction)! * 50))
            self?.totalSlider.fraction += 0.75 * delta / 5
            self?.updateLabels()
        }
        
        // step goal setting slider
        stepSlider.attributedTextForFraction = { fraction in
            let formatter = NumberFormatter()
            formatter.maximumIntegerDigits = 3
            formatter.maximumFractionDigits = 0
            let string = formatter.string(from: (fraction * 40000) as NSNumber) ?? ""
            return NSAttributedString(string: string, attributes: [.font: UIFont.systemFont(ofSize: 10, weight: .medium), .foregroundColor: UIColor.white])
        }
        stepSlider.setMinimumLabelAttributedText(NSAttributedString(string: "0", attributes: labelTextAttributes))
        stepSlider.setMaximumLabelAttributedText(NSAttributedString(string: "40000", attributes: labelTextAttributes))
        stepSlider.fraction = 0.5
        stepSlider.shadowOffset = CGSize(width: 0, height: 10)
        stepSlider.shadowBlur = 5
//        stepSlider.shadowColor = UIColor(white: 0, alpha: 0.1)
        stepSlider.contentViewColor = UIColor(red: 255/255.0, green: 203/255.0, blue: 0/255.0, alpha: 1)
        stepSlider.valueViewColor = .white
        stepSlider.didBeginTracking = { [weak self] _ in
            self?.setLabelHidden(true, animated: true)
            self?.previousStep = (self?.stepSlider.fraction)!
        }
        stepSlider.didEndTracking = { [weak self] _ in
            self?.setLabelHidden(false, animated: true)
            let delta = (self?.stepSlider.fraction)! - self!.previousStep
            self?.stepLabel.text = String(format: "%.1f", Float((self?.stepSlider.fraction)! * 40000))
            self?.totalSlider.fraction += 0.85 * delta / 5
            self?.updateLabels()
        }
    }
    
    private func setLabelHidden(_ hidden: Bool, animated: Bool) {
        let animations = {
            self.totalCalLabel.alpha = hidden ? 0 : 1
            self.workoutHrsLabel.alpha = hidden ? 0 : 1
            self.standingHrsLabel.alpha = hidden ? 0 : 1
            self.walkingKmLabel.alpha = hidden ? 0 : 1
            self.climbingFlrLabel.alpha = hidden ? 0 : 1
            self.stepLabel.alpha = hidden ? 0 : 1
            
        }
        if animated {
            UIView.animate(withDuration: 0.11, animations: animations)
        } else {
            animations()
        }
    }
    
    private func updateLabels() {
        totalCalLabel.text = String(format: "%.1f", Float((totalSlider.fraction) * 4000))
        workoutHrsLabel.text = String(format: "%.1f", Float((workOutSlider.fraction) * 8))
        standingHrsLabel.text = String(format: "%.1f", Float((standingSlider.fraction) * 10))
        walkingKmLabel.text = String(format: "%.1f", Float((walkingSlider.fraction) * 20))
        climbingFlrLabel.text = String(format: "%.1f", Float((climbingSlider.fraction) * 50))
        stepLabel.text = String(format: "%.1f", Float((stepSlider.fraction) * 40000))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        user.total = Float(totalCalLabel.text!) ?? 0.0
        user.workout = Float(workoutHrsLabel.text!) ?? 0.0
        user.standing = Float(standingHrsLabel.text!) ?? 0.0
        user.walking = Float(walkingKmLabel.text!) ?? 0.0
        user.climbing = Float(climbingFlrLabel.text!) ?? 0.0
        user.step = Float(stepLabel.text!) ?? 0.0
    }
    
    func populateLabels() {
        totalSlider.fraction = CGFloat(user.total / 4000)
        workOutSlider.fraction = CGFloat(user.workout / 8)
        standingSlider.fraction = CGFloat(user.standing / 10)
        walkingSlider.fraction = CGFloat(user.walking / 20)
        climbingSlider.fraction = CGFloat(user.climbing / 50)
        stepSlider.fraction = CGFloat(user.step / 40000)
        updateLabels()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
