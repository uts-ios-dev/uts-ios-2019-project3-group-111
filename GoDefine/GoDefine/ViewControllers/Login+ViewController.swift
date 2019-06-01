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
