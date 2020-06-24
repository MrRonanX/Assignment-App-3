//
//  CustomTextField.swift
//  Assignment App 3
//
//  Created by Roman Kavinskyi on 18.06.2020.
//  Copyright © 2020 Roman Kavinskyi. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {
	
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupTextField()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setupTextField() {
		autocorrectionType 			= .no
        returnKeyType 				= .continue
        borderStyle 				= .roundedRect
		textAlignment 				= .left
        contentVerticalAlignment 	= .center
		translatesAutoresizingMaskIntoConstraints = false
	}
}
