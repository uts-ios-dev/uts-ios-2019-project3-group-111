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

        // Do any additional setup after loading the view.
        let labelTextAttributes: [NSAttributedString.Key : Any] = [.font: UIFont.systemFont(ofSize: 10, weight: .medium), .foregroundColor: UIColor.white]
        totalSlider.attributedTextForFraction = { fraction in
            let formatter = NumberFormatter()
            formatter.maximumIntegerDigits = 3
            formatter.maximumFractionDigits = 0
            let string = formatter.string(from: (fraction * 600) as NSNumber) ?? ""
            return NSAttributedString(string: string, attributes: [.font: UIFont.systemFont(ofSize: 10, weight: .medium), .foregroundColor: UIColor.black])
        }
        totalSlider.setMinimumLabelAttributedText(NSAttributedString(string: "0", attributes: labelTextAttributes))
        totalSlider.setMaximumLabelAttributedText(NSAttributedString(string: "600", attributes: labelTextAttributes))
        totalSlider.fraction = 0.5
        totalSlider.shadowOffset = CGSize(width: 0, height: 10)
        totalSlider.shadowBlur = 5
        totalSlider.shadowColor = UIColor(white: 0, alpha: 0.1)
        totalSlider.contentViewColor = UIColor(red: 78/255.0, green: 77/255.0, blue: 224/255.0, alpha: 1)
        totalSlider.valueViewColor = .white
        totalSlider.didBeginTracking = { [weak self] _ in
            self?.setLabelHidden(true, animated: true)
        }
        totalSlider.didEndTracking = { [weak self] _ in
            self?.setLabelHidden(false, animated: true)
            self?.totalCalLabel.text = String(format: "%.1f", Float((self?.totalSlider.fraction)! * 600))
        }
        
        // workout goal setting slider
        workOutSlider.attributedTextForFraction = { fraction in
            let formatter = NumberFormatter()
            formatter.maximumIntegerDigits = 3
            formatter.maximumFractionDigits = 0
            let string = formatter.string(from: (fraction * 600) as NSNumber) ?? ""
            return NSAttributedString(string: string, attributes: [.font: UIFont.systemFont(ofSize: 10, weight: .medium), .foregroundColor: UIColor.black])
        }
        workOutSlider.setMinimumLabelAttributedText(NSAttributedString(string: "0", attributes: labelTextAttributes))
        workOutSlider.setMaximumLabelAttributedText(NSAttributedString(string: "600", attributes: labelTextAttributes))
        workOutSlider.fraction = 0.5
        workOutSlider.shadowOffset = CGSize(width: 0, height: 10)
        workOutSlider.shadowBlur = 5
        workOutSlider.shadowColor = UIColor(white: 0, alpha: 0.1)
        workOutSlider.contentViewColor = UIColor(red: 0/255.0, green: 185/255.0, blue: 2/255.0, alpha: 1)
        workOutSlider.valueViewColor = .white
        workOutSlider.didBeginTracking = { [weak self] _ in
            self?.setLabelHidden(true, animated: true)
        }
        workOutSlider.didEndTracking = { [weak self] _ in
            self?.setLabelHidden(false, animated: true)
            self?.workoutHrsLabel.text = String(format: "%.1f", Float((self?.workOutSlider.fraction)! * 600))
        }
        
        // standing goal setting slider
        standingSlider.attributedTextForFraction = { fraction in
            let formatter = NumberFormatter()
            formatter.maximumIntegerDigits = 3
            formatter.maximumFractionDigits = 0
            let string = formatter.string(from: (fraction * 600) as NSNumber) ?? ""
            return NSAttributedString(string: string, attributes: [.font: UIFont.systemFont(ofSize: 10, weight: .medium), .foregroundColor: UIColor.black])
        }
        standingSlider.setMinimumLabelAttributedText(NSAttributedString(string: "0", attributes: labelTextAttributes))
        standingSlider.setMaximumLabelAttributedText(NSAttributedString(string: "600", attributes: labelTextAttributes))
        standingSlider.fraction = 0.5
        standingSlider.shadowOffset = CGSize(width: 0, height: 10)
        standingSlider.shadowBlur = 5
        standingSlider.shadowColor = UIColor(white: 0, alpha: 0.1)
        standingSlider.contentViewColor = UIColor(red: 137/255.0, green: 95/255.0, blue: 255/255.0, alpha: 1)
        standingSlider.valueViewColor = .white
        standingSlider.didBeginTracking = { [weak self] _ in
            self?.setLabelHidden(true, animated: true)
        }
        standingSlider.didEndTracking = { [weak self] _ in
            self?.setLabelHidden(false, animated: true)
            self?.standingHrsLabel.text = String(format: "%.1f", Float((self?.standingSlider.fraction)! * 600))
        }
        
        // walking goal setting slider
        walkingSlider.attributedTextForFraction = { fraction in
            let formatter = NumberFormatter()
            formatter.maximumIntegerDigits = 3
            formatter.maximumFractionDigits = 0
            let string = formatter.string(from: (fraction * 600) as NSNumber) ?? ""
            return NSAttributedString(string: string, attributes: [.font: UIFont.systemFont(ofSize: 10, weight: .medium), .foregroundColor: UIColor.black])
        }
        walkingSlider.setMinimumLabelAttributedText(NSAttributedString(string: "0", attributes: labelTextAttributes))
        walkingSlider.setMaximumLabelAttributedText(NSAttributedString(string: "600", attributes: labelTextAttributes))
        walkingSlider.fraction = 0.5
        walkingSlider.shadowOffset = CGSize(width: 0, height: 10)
        walkingSlider.shadowBlur = 5
        walkingSlider.shadowColor = UIColor(white: 0, alpha: 0.1)
        walkingSlider.contentViewColor = UIColor(red: 53/255.0, green: 172/255.0, blue: 255/255.0, alpha: 1)
        walkingSlider.valueViewColor = .white
        walkingSlider.didBeginTracking = { [weak self] _ in
            self?.setLabelHidden(true, animated: true)
        }
        walkingSlider.didEndTracking = { [weak self] _ in
            self?.setLabelHidden(false, animated: true)
            self?.walkingKmLabel.text = String(format: "%.1f", Float((self?.walkingSlider.fraction)! * 600))
        }
        
        // climbing goal setting slider
        climbingSlider.attributedTextForFraction = { fraction in
            let formatter = NumberFormatter()
            formatter.maximumIntegerDigits = 3
            formatter.maximumFractionDigits = 0
            let string = formatter.string(from: (fraction * 600) as NSNumber) ?? ""
            return NSAttributedString(string: string, attributes: [.font: UIFont.systemFont(ofSize: 10, weight: .medium), .foregroundColor: UIColor.black])
        }
        climbingSlider.setMinimumLabelAttributedText(NSAttributedString(string: "0", attributes: labelTextAttributes))
        climbingSlider.setMaximumLabelAttributedText(NSAttributedString(string: "600", attributes: labelTextAttributes))
        climbingSlider.fraction = 0.5
        climbingSlider.shadowOffset = CGSize(width: 0, height: 10)
        climbingSlider.shadowBlur = 5
        climbingSlider.shadowColor = UIColor(white: 0, alpha: 0.1)
        climbingSlider.contentViewColor = UIColor(red: 181/255.0, green: 0/255.0, blue: 255/255.0, alpha: 1)
        climbingSlider.valueViewColor = .white
        climbingSlider.didBeginTracking = { [weak self] _ in
            self?.setLabelHidden(true, animated: true)
        }
        climbingSlider.didEndTracking = { [weak self] _ in
            self?.setLabelHidden(false, animated: true)
            self?.climbingFlrLabel.text = String(format: "%.1f", Float((self?.climbingSlider.fraction)! * 600))
        }
        
        // step goal setting slider
        stepSlider.attributedTextForFraction = { fraction in
            let formatter = NumberFormatter()
            formatter.maximumIntegerDigits = 3
            formatter.maximumFractionDigits = 0
            let string = formatter.string(from: (fraction * 600) as NSNumber) ?? ""
            return NSAttributedString(string: string, attributes: [.font: UIFont.systemFont(ofSize: 10, weight: .medium), .foregroundColor: UIColor.black])
        }
        stepSlider.setMinimumLabelAttributedText(NSAttributedString(string: "0", attributes: labelTextAttributes))
        stepSlider.setMaximumLabelAttributedText(NSAttributedString(string: "600", attributes: labelTextAttributes))
        stepSlider.fraction = 0.5
        stepSlider.shadowOffset = CGSize(width: 0, height: 10)
        stepSlider.shadowBlur = 5
        stepSlider.shadowColor = UIColor(white: 0, alpha: 0.1)
        stepSlider.contentViewColor = UIColor(red: 255/255.0, green: 203/255.0, blue: 0/255.0, alpha: 1)
        stepSlider.valueViewColor = .white
        stepSlider.didBeginTracking = { [weak self] _ in
            self?.setLabelHidden(true, animated: true)
        }
        stepSlider.didEndTracking = { [weak self] _ in
            self?.setLabelHidden(false, animated: true)
            self?.stepLabel.text = String(format: "%.1f", Float((self?.stepSlider.fraction)! * 600))
        }
    }
    
    private func setLabelHidden(_ hidden: Bool, animated: Bool) {
        let animations = {
            self.totalCalLabel.alpha = hidden ? 0 : 1
        }
        if animated {
            UIView.animate(withDuration: 0.11, animations: animations)
        } else {
            animations()
        }
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
