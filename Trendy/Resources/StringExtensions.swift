//
//  StringExtensions.swift
//  Trendy
//
//  Created by Eashir Arafat on 11/11/19.
//  Copyright © 2019 eashirarafat. All rights reserved.
//

import Foundation

extension String {
	
	func getStrFromIso8061() -> String? {
		let dateFormatter = DateFormatter()
		let enUSPosixLocale = Locale(identifier: "en_US_POSIX")
		dateFormatter.locale = enUSPosixLocale
		dateFormatter.dateFormat = "HH:mm:ss"
		dateFormatter.calendar = Calendar(identifier: .gregorian)
		
		let iso8601String = dateFormatter.string(from: Date())
		return iso8601String
	}
	
}
