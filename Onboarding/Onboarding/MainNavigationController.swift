//
//  MainNavigationController.swift
//  Onboarding
//
//  Created by Jairo Eli de Leon on 2/6/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

import UIKit

class MainNavigationController: UINavigationController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    
    if isLoggedIn() {
      // assumes user is logged in
      let homeController = HomeController()
      viewControllers = [homeController]
    } else {
      perform(#selector(showLoginController), with: nil, afterDelay: 0.01)
    }
    
  }
  
  // MARK: Login in
  
  fileprivate func isLoggedIn() -> Bool {
    return UserDefaults.Account.bool(forKey: .isUserLoggedIn)
  }
  
  @objc func showLoginController() {
    let loginController = LoginController()
    
    present(loginController, animated: true, completion: {
      // perhaps we'll do something later
    })
  }
  
}
