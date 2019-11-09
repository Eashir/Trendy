//
//  Defaults.swift
//  Trendy
//
//  Created by Eashir Arafat on 11/9/19.
//  Copyright © 2019 eashirarafat. All rights reserved.
//

import Foundation

struct Defaults {
	
	static let userDefaults = UserDefaults.standard
	
	static func save(_ id: String) {
		userDefaults.set("", forKey: id)
	}
	
	static func remove(_ id: String) {
		userDefaults.removeObject(forKey: id)
	}
	
	static func checkIfKeyExists(_ id: String) -> Bool {
		guard userDefaults.value(forKey: id) != nil else {
			return false
		}
		return true
	}
	
}
