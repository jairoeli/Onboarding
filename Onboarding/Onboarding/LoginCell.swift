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
    attachViews()
    setupViews()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Properties
  
  weak var delegate: LoginControllerDelegate?
  
  let logoImageView = UIImageView {
    $0.image = #imageLiteral(resourceName: "logo")
    $0.contentMode = .scaleAspectFit
  }

  let container = UILayoutGuide()
  let spacer = UILayoutGuide()

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

  private func attachViews() {
    addSubview(logoImageView)
    addSubview(emailTextField)
    addSubview(passwordTextField)
    addSubview(loginButton)
    addLayoutGuide(container)
    addLayoutGuide(spacer)
  }
  
  // MARK: - Set up
  
  private func setupViews() {

    container.activate(
      constraint(edgesTo: self.layoutMarginsGuide)
    )

    logoImageView.activate([
      constraint(\.heightAnchor, to: 160),
      constraint(\.widthAnchor, to: 160),
      constraint(same: \.centerXAnchor, as: container),
      constraint(same: \.topAnchor, as: container, offset: DeviceSize.adjust(150, for: [.small: 50, .large: 120]))
    ])

    emailTextField.activate([
      constraint(\.topAnchor, to: \.bottomAnchor, of: logoImageView, offset: 30),
      constraint(\.heightAnchor, to: 50),
      constraint(same: \.leadingAnchor, as: container, offset: 20),
      constraint(same: \.trailingAnchor, as: container, offset: -20)
    ])

    passwordTextField.activate([
      constraint(\.topAnchor, to: \.bottomAnchor, of: emailTextField, offset: 10),
      constraint(\.heightAnchor, to: 50),
      constraint(same: \.leadingAnchor, as: container, offset: 20),
      constraint(same: \.trailingAnchor, as: container, offset: -20)
    ])

    loginButton.activate([
      constraint(\.topAnchor, to: \.bottomAnchor, of: passwordTextField, offset: 10),
      constraint(\.heightAnchor, to: 50),
      constraint(same: \.leadingAnchor, as: container, offset: 20),
      constraint(same: \.trailingAnchor, as: container, offset: -20)
    ])


  }
  
}
