//
//  Dao.swift
//  Onboarding
//
//  Created by Jairo Eli de Leon on 2/6/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

import UIKit

infix operator <==

@discardableResult
public func <== <T>(x: T, f: (T) -> ()) -> T {
  f(x)
  return x
}
