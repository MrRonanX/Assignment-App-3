//
//  Screen2.swift
//  Assignment App 3
//
//  Created by Roman Kavinskyi on 18.06.2020.
//  Copyright © 2020 Roman Kavinskyi. All rights reserved.
//

import UIKit

protocol PassData {
	func passData(person: PersonModel, index: Int?, shouldReset: Bool, people: [PersonModel]?)
	
	func backButtonPressed(shouldReset: Bool)
}

class Screen2: UIViewController {
	
	enum Placeholder: String {
		case name = "Enter the name"
		case email = "Enter the email"
		case phone = "Enter the phone number"
	}

	private let name = CustomTextField()
	
	private let email = CustomTextField ()
	
	private let phone = CustomTextField ()
	
	private let nameLabel = UILabel()
	
	private let emailLabel = UILabel()
	
	private let phoneLabel = UILabel()
	
	private let updateButton = CustomButton()
	
	private let resetButton = CustomButton()
	
	private let nameCheckMark = UIImageView()
	
	private let emailCheckMark = UIImageView()
	
	private let phoneCheckMark = UIImageView ()
	
	var setName: String? {
		didSet {
			name.text = setName
		}
	}
	var setEmail: String? {
		didSet {
			email.text = setEmail
		}
	}
	var setPhone: String? {
		didSet {
			phone.text = setPhone
		}
	}
	var indexPath: Int?
	var transferredPeople: [PersonModel]?
	private let buttonColor = UIColor.init(displayP3Red: 25/255, green: 100/255, blue: 128/255, alpha: 1)
	private var validityType: String.ValidityTyge = .email
	
	private var phoneIsValid = false {
		didSet {
			checkIsTextFieldAreValid()
		}
	}
	
	private var nameIsValid = false {
		didSet {
			checkIsTextFieldAreValid()
		}
	}
	
	private var emailIsValid = false {
		didSet {
			checkIsTextFieldAreValid()
		}
	}
	
	
	var delegate: PassData?
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupView()
		updateButton.backgroundColor = buttonColor.lighter(by: 10)
		initialValidation()  // check is initial data is valid
	}
	
//	override func didMove(toParent parent: UIViewController?) {
//		print((parent as? Screen1)?.shouldReset)
//		print("parent")
//	}
	
	

	
	private func checkIsTextFieldAreValid() {
		// if Valid -> changes Button Color
		
		if phoneIsValid, nameIsValid, emailIsValid {
			updateButton.backgroundColor = buttonColor
		}
	}
	
	
	private func initialValidation() {
		let textFieldsArray = [name, email, phone]
		for textField in textFieldsArray {
			validation(textField)
		}
	}
	
	@objc private func validation(_ sender: CustomTextField) {
		//text Validation
		
		guard let text = sender.text else { return }
		
		switch sender.placeholder! {
		case Placeholder.name.rawValue:
			validityType = .name
			if text.isValid(validityType) {
				nameIsValid = true
				nameCheckMark.alpha = 1
			} else {
				nameIsValid = false
				nameCheckMark.alpha = 0
			}
		case Placeholder.email.rawValue:
			validityType = .email
			if text.isValid(validityType) {
				emailIsValid = true
				emailCheckMark.alpha = 1
			} else {
				emailIsValid = false
				emailCheckMark.alpha = 0
			}
		case Placeholder.phone.rawValue:
			validityType = .phone
			if text.isValid(validityType) {
				phoneIsValid = true
				phoneCheckMark.alpha = 1
			} else {
				phoneIsValid = false
				phoneCheckMark.alpha = 0
			}
		default:
			fatalError("Validation didn't go good")
		}
	}
	
	
	@objc private func updateButtonPressed(_ sender: UIButton) {
		if nameIsValid, emailIsValid, phoneIsValid {
			let person = PersonModel(name: name.text!, email: email.text, phone: phone.text!)
			delegate?.passData(person: person, index: indexPath, shouldReset: false, people: transferredPeople)
			navigationController?.popToRootViewController(animated: true)
			
		} else {
			if !nameIsValid { nameNotValid() }
			else if !emailIsValid { emailNotValid() }
			else if !phoneIsValid { phoneNotValid() }
			
		}
		
		
		
	}
	
	
	
	private func nameNotValid() {
		let alert = UIAlertController(title: "Name isn't valid", message: "Name must be at least 4 characters long and less than 20", preferredStyle: .alert)
		let action = UIAlertAction(title: "OK", style: .default, handler: nil)
		alert.addAction(action)
		present(alert, animated: true)
	}
	
	private func emailNotValid() {
		let alert = UIAlertController(title: "Email isn't valid", message: "Please, enter valid email!", preferredStyle: .alert)
		let action = UIAlertAction(title: "OK", style: .default, handler: nil)
		alert.addAction(action)
		present(alert, animated: true)
	}
	
	private func phoneNotValid() {
		let alert = UIAlertController(title: "Phone number isn't valid", message: "There must be 10 numeric characters.", preferredStyle: .alert)
		let action = UIAlertAction(title: "OK", style: .default, handler: nil)
		alert.addAction(action)
		present(alert, animated: true)
	}
	
	
	@objc private func resetButtonPressed (_ sender: UIButton) {
		delegate?.backButtonPressed(shouldReset: true)
		navigationController?.popViewController(animated: true)
		
	}
	
	
	private func setupView() {
		view.backgroundColor = .white
		let margin = view.bounds.height / 14
		let width = view.bounds.width * 0.9
		let buttonWidth = view.bounds.width * 0.8
		let checkMarkSize: CGFloat = 20
		
		
		//		NAME TEXTFIELD
		
		view.addSubview(name)
		name.placeholder = Placeholder.name.rawValue
		name.addTarget(self, action: #selector(validation(_ :)), for: .editingChanged)
		NSLayoutConstraint.activate([
			name.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: margin),
			name.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
			name.heightAnchor.constraint(equalToConstant: 30),
			name.widthAnchor.constraint(equalToConstant: width)
		])
		
		//		NAME LABEL
		
		view.addSubview(nameLabel)
		nameLabel.text = "Name:"
		nameLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
		nameLabel.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			nameLabel.heightAnchor.constraint(equalToConstant: 20),
			nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
			nameLabel.bottomAnchor.constraint(equalTo: name.topAnchor, constant: -5)
		])
		
		//		NAME CHECKMARK
		view.addSubview(nameCheckMark)
		nameCheckMark.translatesAutoresizingMaskIntoConstraints = false
		nameCheckMark.image = UIImage(systemName: "checkmark")
		nameCheckMark.tintColor = .systemGreen
		nameCheckMark.alpha = 0
		NSLayoutConstraint.activate([
			nameCheckMark.topAnchor.constraint(equalTo: nameLabel.topAnchor),
			nameCheckMark.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 5),
			nameCheckMark.heightAnchor.constraint(equalToConstant: checkMarkSize),
			nameCheckMark.widthAnchor.constraint(equalToConstant: checkMarkSize)
		])
		
		//		EMAIL TEXTFIELD
		
		view.addSubview(email)
		email.keyboardType = .emailAddress
		email.placeholder = Placeholder.email.rawValue
		email.addTarget(self, action: #selector(validation(_ :)), for: .editingChanged)
		NSLayoutConstraint.activate([
			email.topAnchor.constraint(equalTo: name.bottomAnchor, constant: margin),
			email.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
			email.heightAnchor.constraint(equalToConstant: 30),
			email.widthAnchor.constraint(equalToConstant: width)
		])
		
		//		EMAIL LABEL
		
		view.addSubview(emailLabel)
		emailLabel.text = "E-mail:"
		emailLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
		emailLabel.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			emailLabel.heightAnchor.constraint(equalToConstant: 20),
			emailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
			emailLabel.bottomAnchor.constraint(equalTo: email.topAnchor, constant: -5)
		])
		
		//		EMAIL CHECKMARK
		view.addSubview(emailCheckMark)
		emailCheckMark.translatesAutoresizingMaskIntoConstraints = false
		emailCheckMark.image = UIImage(systemName: "checkmark")
		emailCheckMark.tintColor = .systemGreen
		emailCheckMark.alpha = 0
		NSLayoutConstraint.activate([
			emailCheckMark.topAnchor.constraint(equalTo: emailLabel.topAnchor),
			emailCheckMark.leadingAnchor.constraint(equalTo: emailLabel.trailingAnchor, constant: 5),
			emailCheckMark.heightAnchor.constraint(equalToConstant: checkMarkSize),
			emailCheckMark.widthAnchor.constraint(equalToConstant: checkMarkSize)
		])
		
		//		PHONE TEXTFIELD
		
		view.addSubview(phone)
		phone.keyboardType = .numberPad
		phone.placeholder = Placeholder.phone.rawValue
		phone.addTarget(self, action: #selector(validation(_:)), for: .editingChanged)
		NSLayoutConstraint.activate([
			phone.topAnchor.constraint(equalTo: email.bottomAnchor, constant: margin),
			phone.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
			phone.heightAnchor.constraint(equalToConstant: 30),
			phone.widthAnchor.constraint(equalToConstant: width)
		])
		
		//		PHONE LABEL
		
		view.addSubview(phoneLabel)
		phoneLabel.text = "Phone:"
		phoneLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
		phoneLabel.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			phoneLabel.heightAnchor.constraint(equalToConstant: 20),
			phoneLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
			phoneLabel.bottomAnchor.constraint(equalTo: phone.topAnchor, constant: -5)
		])
		
		//		EMAIL CHECKMARK
		view.addSubview(phoneCheckMark)
		phoneCheckMark.translatesAutoresizingMaskIntoConstraints = false
		phoneCheckMark.image = UIImage(systemName: "checkmark")
		phoneCheckMark.tintColor = .systemGreen
		phoneCheckMark.alpha = 0
	
		NSLayoutConstraint.activate([
			phoneCheckMark.topAnchor.constraint(equalTo: phoneLabel.topAnchor),
			phoneCheckMark.leadingAnchor.constraint(equalTo: phoneLabel.trailingAnchor, constant: 5),
			phoneCheckMark.heightAnchor.constraint(equalToConstant: checkMarkSize),
			phoneCheckMark.widthAnchor.constraint(equalToConstant: checkMarkSize)
		])
		
		//		UPDATE BUTTON
		
		view.addSubview(updateButton)
		updateButton.setTitle("Update", for: .normal)
		updateButton.addTarget(self, action: #selector(updateButtonPressed(_:)), for: .touchUpInside)
		NSLayoutConstraint.activate([
			updateButton.topAnchor.constraint(equalTo: phone.bottomAnchor, constant: margin/2),
			updateButton.heightAnchor.constraint(equalToConstant: 50),
			updateButton.widthAnchor.constraint(equalToConstant: buttonWidth),
			updateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
		])
		
		//		RESET BUTTON
		
		view.addSubview(resetButton)
		resetButton.setTitle("Reset", for: .normal)
		resetButton.addTarget(self, action: #selector(resetButtonPressed(_:)), for: .touchUpInside)
		NSLayoutConstraint.activate([
			resetButton.topAnchor.constraint(equalTo: updateButton.bottomAnchor, constant: margin/2),
			resetButton.heightAnchor.constraint(equalToConstant: 50),
			resetButton.widthAnchor.constraint(equalToConstant: buttonWidth),
			resetButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
		])
		
	}
	
}


