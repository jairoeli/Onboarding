//
//  Dao.swift
//  Onboarding
//
//  Created by Jairo Eli de Leon on 2/6/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

import UIKit

protocol Dao {}
extension NSObject: Dao {}

extension Dao where Self: NSObject {
  
  init(closure: (Self) -> Void) {
    self.init()
    closure(self)
  }
  
}

extension Dao where Self: UIButton {
  
  init(type: UIButtonType, closure: (Self) -> Void) {
    self = UIButton(type: type) as! Self
    closure(self)
  }
  
}

infix operator <==

@discardableResult
public func <== <T>(x: T, f: (T) -> ()) -> T {
  f(x)
  return x
}
