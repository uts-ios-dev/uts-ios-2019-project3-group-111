//
//  LoginViewController.swift
//  GoDefine
//
//  Created by Yang Qijun on 27/5/19.
//  Copyright © 2019 Yang Qijun. All rights reserved.
//

import UIKit
import SwiftyOnboard

class LoginViewController: UIViewController {
    let user = User()
    override var prefersStatusBarHidden: Bool { return true }
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation { return .fade }
    override var prefersHomeIndicatorAutoHidden: Bool { return true }
    
    @IBOutlet weak var backgroundView: UIImageView!
    @IBOutlet weak var buttonView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let introView = SwiftyOnboard(frame: .zero, style: .light)
        
        view.addSubview(introView)
        
        introView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(buttonView.snp.top)
        }
        introView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("\(String(describing: user.name))")
        if let _ = user.name {
            performSegue(withIdentifier: "EnterHomeDirect", sender: nil)
            return
        }
        
        if backgroundView.layer.animation(forKey: "shift") == nil {
            startBackgroundAnimation()
        }
    }
    
    private func startBackgroundAnimation() {
        let rightLength = backgroundView.frame.maxX - view.frame.maxX
        let leftLength = view.frame.minX - backgroundView.frame.minX
        
        let shiftAnimation = CAKeyframeAnimation(keyPath: "position.x")
        shiftAnimation.values = [0, rightLength, 0, -leftLength, 0]
        shiftAnimation.timingFunction = .linear
        shiftAnimation.duration = 150.0
        shiftAnimation.isAdditive = true
        shiftAnimation.repeatCount = Float.infinity
        
        backgroundView.layer.add(shiftAnimation, forKey: "shift")
    }
    
    private func introPageTitle(at index: Int) -> String? {
        switch index {
        case 0:
            return "Becoming the best version of yourself"
        case 1:
            return "Having fun while keeping fitness!"
        case 2:
            return "Intro title 3"
            
        default:
            return nil
        }
    }
    
    private func introPageSubtitle(at index: Int) -> String? {
        switch index {
        case 0:
            return "Join us to motivate your daily workouts for a higher and stronger goal"
        case 1:
            return "Join us to motivate your daily workouts for a higher and stronger goal"
        case 2:
            return "Intro subtitle 3"
        default:
            return nil
        }
    }
    
    private func introPageImage(at index: Int) -> UIImage? {
        switch index {
        case 1:
            return UIImage(named: "intro_icon") // 128x128 is better resolution
        default:
            return nil
        }
    }
}

extension LoginViewController: SwiftyOnboardDataSource {
    func swiftyOnboardNumberOfPages(_ swiftyOnboard: SwiftyOnboard) -> Int {
        return 3
    }
    
    func swiftyOnboardPageForIndex(_ swiftyOnboard: SwiftyOnboard, index: Int) -> SwiftyOnboardPage? {
        let page = SwiftyOnboardPage()
        page.title.font = UIFont.systemFont(ofSize: 40, weight: .light)
        page.subTitle.font = UIFont.systemFont(ofSize: 20, weight: .light)
        
        page.title.text = introPageTitle(at: index)
        page.subTitle.text = introPageSubtitle(at: index)
        page.imageView.image = introPageImage(at: index)
        page.imageView.contentMode = .center
        return page
    }
    
    func swiftyOnboardViewForOverlay(_ swiftyOnboard: SwiftyOnboard) -> SwiftyOnboardOverlay? {
        let overlay = SwiftyOnboardOverlay()
        overlay.continueButton.isHidden = true
        overlay.skipButton.isHidden = true
        return overlay
    }
}
