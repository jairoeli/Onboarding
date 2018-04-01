//
//  Subviews.swift
//  Onboarding
//
//  Created by Jairo Eli de Leon on 4/1/18.
//  Copyright © 2018 DevMountain. All rights reserved.
//

import UIKit

protocol AddSubviews {}

extension AddSubviews where Self: UIView {

  /// Add views to the end of the receiver’s list of subviews.
  /// This method establishes a strong reference to view and sets its next responder to the receiver, which is its new superview.
  /// Views can have only one superview. If view already has a superview and that view is not the receiver, this method removes the previous superview before making the receiver its new superview.
  ///
  ///     self.view.add(
  ///       self.titleLabel,
  ///       self.descriptionLabel,
  ///       self.imageView
  ///     )
  ///
  /// - Parameter subviews: The collection of views to be added. After being added, this views appear on top of any other subviews.
  func add(_ subviews: [UIView]) {
    subviews.forEach {
      self.addSubview($0)
    }
  }

}

extension UIView: AddSubviews {}
