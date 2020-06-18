//
//  Extensions.swift
//  Assignment App 3
//
//  Created by Roman Kavinskyi on 18.06.2020.
//  Copyright © 2020 Roman Kavinskyi. All rights reserved.
//

import UIKit

extension String {
	
	enum ValidityTyge {
		case phone
		case email
		case name
	}
	
	enum Regex: String {
		case phone		= "[0-9]{10,10}"
		case email	 	= "[0-9A-Za-z._%+-]+@[0-9A-Za-z._%+-]+\\.[A-Za-z]{2,64}"
		case name 		= "[A-Za-z ]{4,20}"
	}
	 
	func isValid(_ validityType: ValidityTyge) -> Bool {
		let format 	= "SELF MATCHES %@"
		var regex 	= ""
		
		switch validityType {
		case .phone:
			regex = Regex.phone.rawValue
		case .email:
			regex = Regex.email.rawValue
		case .name:
			regex = Regex.name.rawValue
		}
		
		return NSPredicate(format: format, regex).evaluate(with: self)
	}
}

extension UIColor {

    func lighter(by percentage: CGFloat = 30.0) -> UIColor? {
        return self.adjust(by: abs(percentage) )
    }

    func darker(by percentage: CGFloat = 30.0) -> UIColor? {
        return self.adjust(by: -1 * abs(percentage) )
    }

    func adjust(by percentage: CGFloat = 30.0) -> UIColor? {
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        if self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            return UIColor(red: min(red + percentage/100, 1.0),
                           green: min(green + percentage/100, 1.0),
                           blue: min(blue + percentage/100, 1.0),
                           alpha: alpha)
        } else {
            return nil
        }
    }
}
