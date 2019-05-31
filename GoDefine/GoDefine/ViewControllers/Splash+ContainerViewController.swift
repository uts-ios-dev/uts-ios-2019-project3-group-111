//
//  SplashViewController.swift
//  GoDefine
//
//  Created by Viola Wang on 31/5/19.
//  Copyright © 2019 Yang Qijun. All rights reserved.
//

import UIKit
import SnapKit
import Motion

enum ViewTags: Int {
    case logo = 1
    case title = 2
}

struct Splash {
    static func loadLaunchScreen() -> ContainerViewController {
        let storyboard = UIStoryboard(name: "LaunchScreen", bundle: nil)
        guard let viewController = storyboard.instantiateInitialViewController() else {
            fatalError("Cannot load launch screen")
        }
        return ContainerViewController(splashViewController: viewController)
    }
    
    class ContainerViewController: UIViewController {
        private let splashViewController: UIViewController
        private lazy var logoView: UIView = {
            guard let view = (splashViewController.view.subviews.first { $0.tag == ViewTags.logo.rawValue }) else {
                fatalError()
            }
            return view
        }()
        
        private lazy var titleView: UIView = {
            guard let view = (splashViewController.view.subviews.first { $0.tag == ViewTags.title.rawValue }) else {
                fatalError()
            }
            return view
        }()
        
        init(splashViewController: UIViewController) {
            self.splashViewController = splashViewController
            super.init(nibName: nil, bundle: nil)
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError()
        }
        
        override func loadView() {
            let view = UIView()
            self.view = view
            view.backgroundColor = .black
            view.addSubview(splashViewController.view)
            splashViewController.view.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            addChild(splashViewController)
        }
        
        func startAnimation() {
            // Logo animation
            logoView.animate([.scale(0), .duration(0.8)]) {
                self.splashViewController.view.animate(.background(color: .white),
                                                       .delay(0.5),
                                                       .duration(1))
                self.logoView.animate([.scale(2.0), .spin(y: 1.0), .fade(0), .duration(1.5)]) {
                    self.showLogin()
                }
            }
            
            // Title animation
            titleView.animate([.translate(y: 100), .fade(0), .duration(1.5)])
        }
        
        func showLogin() {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            guard let viewController = storyboard.instantiateInitialViewController() else { return }
            viewController.view.alpha = 0.0
            (UIApplication.shared.delegate as? AppDelegate)?.window?.rootViewController = viewController
            viewController.view.animate([.fade(1.0), .duration(0.3)])
        }
    }
}
