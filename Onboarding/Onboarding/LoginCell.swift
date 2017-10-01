//
//  LoginCell.swift
//  Onboarding
//
//  Created by Jairo Eli de Leon on 2/6/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

import UIKit

class LoginCell: UICollectionViewCell {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Properties
  
  weak var delegate: LoginControllerDelegate?
  
  let logoImageView = UIImageView {
    $0.image = #imageLiteral(resourceName: "logo")
  }
  
  lazy var emailTextField: LeftPaddedTextField = {
    let email = LeftPaddedTextField()
    email.placeholder = "Email"
    email.font = UIFont.systemFont(ofSize: 16)
    email.textColor = .black
    email.layer.borderColor = UIColor(white: 0.9, alpha: 1).cgColor
    email.layer.borderWidth = 1
    email.delegate = self
    email.keyboardType = .emailAddress
    email.autocapitalizationType = .none
    email.autocorrectionType = .no
    email.returnKeyType = .next
    email.layer.cornerRadius = 4
    email.layer.masksToBounds = true
    email.clearButtonMode = .whileEditing
    return email
  }()
  
  lazy var passwordTextField: LeftPaddedTextField = {
    let password = LeftPaddedTextField()
    password.delegate = self
    password.placeholder = "Password"
    password.layer.borderColor = UIColor(white: 0.9, alpha: 1).cgColor
    password.layer.borderWidth = 1
    password.font = UIFont.systemFont(ofSize: 16)
    password.textColor = .black
    password.isSecureTextEntry = true
    password.returnKeyType = .go
    password.clearButtonMode = .whileEditing
    password.layer.cornerRadius = 4
    password.layer.masksToBounds = true
    return password
  }()
  
  lazy var loginButton: UIButton = {
    let button = UIButton(type: .system)
    button.backgroundColor = UIColor.rgb(red: 43, green: 46, blue: 74)
    button.setTitle("Log in", for: .normal)
    button.setTitleColor(.white, for: .normal)
    button.layer.cornerRadius = 4
    button.layer.masksToBounds = true
    button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
    return button
  }()
  
  // MARK: - Handle login
  @objc func handleLogin() {
    delegate?.finishLoggingIn()
  }
  
  // MARK: - Set up
  
  func setupViews() {
    
    addSubview(logoImageView)
    addSubview(emailTextField)
    addSubview(passwordTextField)
    addSubview(loginButton)
    
    _ = logoImageView.anchors(centerYAnchor, left: nil, bottom: nil, right: nil, topConstant: -230, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 160, heightConstant: 160)
    
    logoImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    
    _ = emailTextField.anchors(logoImageView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 16, leftConstant: 32, bottomConstant: 0, rightConstant: 32, widthConstant: 0, heightConstant: 50)
    
    _ = passwordTextField.anchors(emailTextField.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 16, leftConstant: 32, bottomConstant: 0, rightConstant: 32, widthConstant: 0, heightConstant: 50)
    
    _ = loginButton.anchors(passwordTextField.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 16, leftConstant: 32, bottomConstant: 0, rightConstant: 32, widthConstant: 0, heightConstant: 50)
    
  }
  
}
