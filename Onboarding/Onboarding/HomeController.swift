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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.title = "We're logged in"
    
    navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Sign Out", style: .plain, target: self, action: #selector(handleSignOut))
    
    view.addSubview(imageView)
    _ = imageView.anchors(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 64, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
  }
  
  func handleSignOut() {
    UserDefaults.Account.set(false, forKey: .isUserLoggedIn)
    
    let loginController = LoginController()
    present(loginController, animated: true, completion: nil)
  }
  
}
