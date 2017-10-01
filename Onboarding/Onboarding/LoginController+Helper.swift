//
//  LoginController+Helper.swift
//  Onboarding
//
//  Created by Jairo Eli de Leon on 2/6/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

import UIKit

protocol LoginControllerDelegate: class {
  func finishLoggingIn()
}

extension LoginController: LoginControllerDelegate {
  
  // MARK: - Animation
  
  func spring(duration: TimeInterval, animations: (() -> Void)!) {
    
    UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
      
      animations()
      
    }, completion: nil)
    
  }
  
  // MARK: - Skip & Next Action
  
  @objc func nextPage() {
    // we are on the last page
    if pageControl.currentPage == pages.count {
      return
    }
    
    // second last page
    if pageControl.currentPage == pages.count - 1 {
      moveControlConstraintsOffScreen()
      
      spring(duration: 0.5) {
        self.view.layoutIfNeeded()
      }
    }
    
    let indexPath = IndexPath(item: pageControl.currentPage + 1, section: 0)
    collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    pageControl.currentPage += 1
  }
  
  @objc func skip() {
    pageControl.currentPage = pages.count - 1
    nextPage()
  }
  
  fileprivate func moveControlConstraintsOffScreen() {
    pageControlBottomAnchor?.constant = 60
    skipButtonTopAnchor?.constant = 60
    nextButtonTopAnchor?.constant = 60
  }
  
  // MARK: - Keyboard
  
  func observeKeyboardNotificaitons() {
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow), name: .UIKeyboardWillShow, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide), name: .UIKeyboardWillHide, object: nil)
  }
  
  @objc func keyboardShow() {
    spring(duration: 0.5) {
      self.view.frame = CGRect(x: 0, y: -60, width: self.view.frame.width, height: self.view.frame.height)
    }
  }
  
  @objc func keyboardHide() {
    spring(duration: 0.5) {
      self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
    }
  }
  
  // MARK: - Scroll
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    view.endEditing(true)
  }
  
  func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    
    let pageNumber = Int(targetContentOffset.pointee.x / view.frame.width)
    pageControl.currentPage = pageNumber
    
    // we are on the last page
    if pageNumber == pages.count {
      moveControlConstraintsOffScreen()
    } else {
      // back on regular pages
      pageControlBottomAnchor?.constant = 0
      skipButtonTopAnchor?.constant = 0
      nextButtonTopAnchor?.constant = 0
    }
    
    spring(duration: 0.5) {
      self.view.layoutIfNeeded()
    }
    
  }
  
  // MARK: - Login
  func finishLoggingIn() {
    let rootViewController = UIApplication.shared.keyWindow?.rootViewController
    guard let mainNavigationController = rootViewController as? MainNavigationController else { return }
    mainNavigationController.viewControllers = [HomeController()]
    
    UserDefaults.Account.set(true, forKey: .isUserLoggedIn)
    
    dismiss(animated: true, completion: nil)
  }
  
  
}
