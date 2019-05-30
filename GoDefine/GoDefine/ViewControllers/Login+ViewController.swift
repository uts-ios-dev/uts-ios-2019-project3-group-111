//
//  LoginViewController.swift
//  GoDefine
//
//  Created by Yang Qijun on 27/5/19.
//  Copyright © 2019 Yang Qijun. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override var prefersStatusBarHidden: Bool { return true }
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation { return .fade }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
<<<<<<< HEAD:GoDefine/GoDefine/ViewControllers/Login+ViewController.swift
    
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

=======
>>>>>>> master:GoDefine/GoDefine/ViewControllers/LoginViewController.swift
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
