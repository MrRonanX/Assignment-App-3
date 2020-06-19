//
//  Screen2.swift
//  Assignment App 3
//
//  Created by Roman Kavinskyi on 18.06.2020.
//  Copyright © 2020 Roman Kavinskyi. All rights reserved.
//

import UIKit

class Screen2: UIViewController {
	
	enum Placeholder: String {
		case name = "Enter the name"
		case email = "Enter the email"
		case phone = "Enter the phone number"
	}
	
	
	
	private let name: CustomTextField = {
		let textField = CustomTextField()
		textField.placeholder = Placeholder.name.rawValue
		textField.translatesAutoresizingMaskIntoConstraints = false
		textField.addTarget(self, action: #selector(validation(_ :)), for: .editingChanged)
		return textField
	}()
	
	private let email: CustomTextField = {
		let textField = CustomTextField()
		textField.placeholder = Placeholder.email.rawValue
		textField.translatesAutoresizingMaskIntoConstraints = false
		textField.addTarget(self, action: #selector(validation(_ :)), for: .editingChanged)
		return textField
	}()
	
	private let phone: CustomTextField = {
		let textField = CustomTextField()
		textField.placeholder = Placeholder.phone.rawValue
		textField.translatesAutoresizingMaskIntoConstraints = false
		textField.addTarget(self, action: #selector(validation(_:)), for: .editingChanged)
		return textField
	}()
	
	private let nameLabel: UILabel = {
		let label = UILabel()
		label.text = "Name:"
		label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	private let emailLabel: UILabel = {
		let label = UILabel()
		label.text = "E-mail:"
		label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	private let phoneLabel: UILabel = {
		let label = UILabel()
		label.text = "Phone:"
		label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	private let updateButton: CustomButton = {
		let button = CustomButton()
		button.setTitle("Update", for: .normal)
		button.setTitleColor(.white, for: .normal)
		button.addTarget(self, action: #selector(updateButtonPressed(_:)), for: .touchUpInside)
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
	}()
	
	private let resetButton: CustomButton = {
		let button = CustomButton()
		button.setTitle("Reset", for: .normal)
		button.setTitleColor(.white, for: .normal)
		button.addTarget(self, action: #selector(resetButtonPressed(_:)), for: .touchUpInside)
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
	}()
	
	private let nameCheckMark: UIImageView = {
		let image = UIImageView()
		image.translatesAutoresizingMaskIntoConstraints = false
		image.image = UIImage(systemName: "checkmark")
		image.tintColor = .systemGreen
		image.alpha = 0
		return image
	}()
	
	private let emailCheckMark: UIImageView = {
		let image = UIImageView()
		image.translatesAutoresizingMaskIntoConstraints = false
		image.image = UIImage(systemName: "checkmark")
		image.tintColor = .systemGreen
		image.alpha = 0
		return image
	}()
	
	private let phoneCheckMark: UIImageView = {
		let image = UIImageView()
		image.translatesAutoresizingMaskIntoConstraints = false
		image.image = UIImage(systemName: "checkmark")
		image.tintColor = .systemGreen
		image.alpha = 0
		return image
	}()
	
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
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupView()
		updateButton.backgroundColor = buttonColor.lighter(by: 10)
		initialValidation()  // check is initial data is valid
	}
	
	private func setupView() {
		let margin = view.bounds.height / 14
		let width = view.bounds.width * 0.9
		let buttonWidth = view.bounds.width * 0.8
		let checkMarkSize: CGFloat = 20
		
		
		//		NAME TEXTFIELD
		
		view.addSubview(name)
		NSLayoutConstraint.activate([
			name.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: margin),
			name.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
			name.heightAnchor.constraint(equalToConstant: 30),
			name.widthAnchor.constraint(equalToConstant: width)
		])
		
		//		NAME LABEL
		
		view.addSubview(nameLabel)
		NSLayoutConstraint.activate([
			nameLabel.heightAnchor.constraint(equalToConstant: 20),
			nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
			nameLabel.bottomAnchor.constraint(equalTo: name.topAnchor, constant: -5)
		])
		
		//		NAME CHECKMARK
		view.addSubview(nameCheckMark)
		NSLayoutConstraint.activate([
			nameCheckMark.topAnchor.constraint(equalTo: nameLabel.topAnchor),
			nameCheckMark.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 5),
			nameCheckMark.heightAnchor.constraint(equalToConstant: checkMarkSize),
			nameCheckMark.widthAnchor.constraint(equalToConstant: checkMarkSize)
		])
		
		//		EMAIL TEXTFIELD
		
		view.addSubview(email)
		email.keyboardType = .emailAddress
		NSLayoutConstraint.activate([
			email.topAnchor.constraint(equalTo: name.bottomAnchor, constant: margin),
			email.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
			email.heightAnchor.constraint(equalToConstant: 30),
			email.widthAnchor.constraint(equalToConstant: width)
		])
		
		//		EMAIL LABEL
		
		view.addSubview(emailLabel)
		NSLayoutConstraint.activate([
			emailLabel.heightAnchor.constraint(equalToConstant: 20),
			emailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
			emailLabel.bottomAnchor.constraint(equalTo: email.topAnchor, constant: -5)
		])
		
		//		EMAIL CHECKMARK
		view.addSubview(emailCheckMark)
		NSLayoutConstraint.activate([
			emailCheckMark.topAnchor.constraint(equalTo: emailLabel.topAnchor),
			emailCheckMark.leadingAnchor.constraint(equalTo: emailLabel.trailingAnchor, constant: 5),
			emailCheckMark.heightAnchor.constraint(equalToConstant: checkMarkSize),
			emailCheckMark.widthAnchor.constraint(equalToConstant: checkMarkSize)
		])
		
		//		PHONE TEXTFIELD
		
		view.addSubview(phone)
		phone.keyboardType = .numberPad
		NSLayoutConstraint.activate([
			phone.topAnchor.constraint(equalTo: email.bottomAnchor, constant: margin),
			phone.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
			phone.heightAnchor.constraint(equalToConstant: 30),
			phone.widthAnchor.constraint(equalToConstant: width)
		])
		
		//		PHONE LABEL
		
		view.addSubview(phoneLabel)
		NSLayoutConstraint.activate([
			phoneLabel.heightAnchor.constraint(equalToConstant: 20),
			phoneLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
			phoneLabel.bottomAnchor.constraint(equalTo: phone.topAnchor, constant: -5)
		])
		
		//		EMAIL CHECKMARK
		view.addSubview(phoneCheckMark)
		NSLayoutConstraint.activate([
			phoneCheckMark.topAnchor.constraint(equalTo: phoneLabel.topAnchor),
			phoneCheckMark.leadingAnchor.constraint(equalTo: phoneLabel.trailingAnchor, constant: 5),
			phoneCheckMark.heightAnchor.constraint(equalToConstant: checkMarkSize),
			phoneCheckMark.widthAnchor.constraint(equalToConstant: checkMarkSize)
		])
		
		//		UPDATE BUTTON
		
		view.addSubview(updateButton)
		NSLayoutConstraint.activate([
			updateButton.topAnchor.constraint(equalTo: phone.bottomAnchor, constant: margin/2),
			updateButton.heightAnchor.constraint(equalToConstant: 50),
			updateButton.widthAnchor.constraint(equalToConstant: buttonWidth),
			updateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
		])
		
		//		RESET BUTTON
		
		view.addSubview(resetButton)
		NSLayoutConstraint.activate([
			resetButton.topAnchor.constraint(equalTo: updateButton.bottomAnchor, constant: margin/2),
			resetButton.heightAnchor.constraint(equalToConstant: 50),
			resetButton.widthAnchor.constraint(equalToConstant: buttonWidth),
			resetButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
		])
		
	}
	
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
			let person = PersonModel(name: name.text!, email: email.text!, phone: phone.text!)
			if let rootVC = navigationController?.viewControllers.first as? Screen1 {
				rootVC.transferredPerson = person
				rootVC.index = indexPath
				rootVC.shouldReset = false
				rootVC.transferredPeople = transferredPeople
			}
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
		
		navigationController?.popViewController(animated: true)
		
	}
	
}
