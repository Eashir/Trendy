//
//  StringExtensions.swift
//  Trendy
//
//  Created by Eashir Arafat on 11/11/19.
//  Copyright © 2019 eashirarafat. All rights reserved.
//

import Foundation

extension String {
	
	func getDurationStrFromIso8601() -> String? {
		var minutes: Int = 0
		var seconds: Int = 0
	
			var lastIndex = self.startIndex
			
			if let indexT = self.firstIndex(of: "T") {
				lastIndex = self.index(after: indexT)
				
				if let indexM = self.firstIndex(of: "M") {
					let min = String(self[lastIndex..<indexM])
					minutes = Int(min) ?? 0
					lastIndex = self.index(after: indexM)
				}
				
				if let indexS = self.firstIndex(of: "S") {
					let sec = String(self[lastIndex..<indexS])
					seconds = Int(sec) ?? 0
				}
			}
		
		return String(format: "%02d:%02d", minutes, seconds)
	}
	
}
