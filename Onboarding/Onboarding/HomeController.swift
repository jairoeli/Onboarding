//
//  HomeController.swift
//  Onboarding
//
//  Created by Jairo Eli de Leon on 2/6/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

import UIKit

class HomeController: UIViewController {
  
  let imageView = UIImageView {
    $0.image = #imageLiteral(resourceName: "home")
  }

  let container = UILayoutGuide()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.title = "We're logged in"
    
    navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Sign Out", style: .plain, target: self, action: #selector(handleSignOut))
    
    view.addSubview(imageView)
    view.addLayoutGuide(container)

    container.activate(
      constraint(edgesTo: view.layoutMarginsGuide)
    )

    imageView.activate([
      constraint(same: \.topAnchor, as: container),
      constraint(same: \.leadingAnchor, as: self.view),
      constraint(same: \.trailingAnchor, as: self.view),
      constraint(same: \.bottomAnchor, as: container)
    ])


  }
  
  @objc func handleSignOut() {
    UserDefaults.Account.set(false, forKey: .isUserLoggedIn)
    
    let loginController = LoginController()
    present(loginController, animated: true, completion: nil)
  }
  
}
