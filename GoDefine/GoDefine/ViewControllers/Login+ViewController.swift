//
//  LoginViewController.swift
//  GoDefine
//
//  Created by Yang Qijun on 27/5/19.
//  Copyright © 2019 Yang Qijun. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    let user = User()
    override var prefersStatusBarHidden: Bool { return true }
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation { return .fade }
    
    @IBOutlet weak var backgroundView: UIImageView?
    @IBOutlet weak var buttonView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("\(String(describing: user.name))")
        if let _ = user.name {
            performSegue(withIdentifier: "EnterHomeDirect", sender: nil)
        }
        
        if backgroundView?.layer.animation(forKey: "shift") == nil {
            startBackgroundAnimation()
        }
    }
    
    private func startBackgroundAnimation() {
        guard let backgroundView = backgroundView else { return }
        let rightLength = backgroundView.frame.maxX - view.frame.maxX
        let leftLength = view.frame.minX - backgroundView.frame.minX
        
        let shiftAnimation = CAKeyframeAnimation(keyPath: "position.x")
        shiftAnimation.values = [0, -leftLength, 0, rightLength, 0]
        shiftAnimation.timingFunction = .linear
        shiftAnimation.duration = 100.0
        shiftAnimation.isAdditive = true
        shiftAnimation.repeatCount = Float.infinity
        
        backgroundView.layer.add(shiftAnimation, forKey: "shift")
    }

}
