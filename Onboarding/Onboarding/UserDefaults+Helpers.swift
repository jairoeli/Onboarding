//
//  UserDefaults+Helpers.swift
//  Onboarding
//
//  Created by Jairo Eli de Leon on 2/6/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

import Foundation

protocol KeyNamespaceable {}

extension KeyNamespaceable {
  static func namespace<T: RawRepresentable>(_ key: T) -> String {
    return "\(Self.self).\(key.rawValue)"
  }
}

protocol BoolUserDefaultable: KeyNamespaceable {
  associatedtype BoolDefaultKey: RawRepresentable
}

extension BoolUserDefaultable where BoolDefaultKey.RawValue == String {
  
  // Setter
  static func set(_ value: Bool, forKey key: BoolDefaultKey) {
    let key = namespace(key)
    UserDefaults.standard.set(value, forKey: key)
  }
  
  // Getter
  static func bool(forKey key: BoolDefaultKey) -> Bool {
    let key = namespace(key)
    return UserDefaults.standard.bool(forKey: key)
  }
  
}

extension UserDefaults {
  
  struct Account: BoolUserDefaultable {
    private init() {}
    enum BoolDefaultKey: String {
      case isUserLoggedIn
    }
  }
  
}
