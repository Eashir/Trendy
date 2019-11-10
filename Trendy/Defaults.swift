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
		userDefaults.set("like", forKey: id)
	}
	
	static func remove(_ id: String) {
		userDefaults.removeObject(forKey: id)
	}
	
	static func exists(key: String) -> Bool {
		return UserDefaults.standard.object(forKey: key) != nil
	}

	
}
