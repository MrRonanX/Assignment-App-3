//
//  ViewController.swift
//  Assignment App 3
//
//  Created by Roman Kavinskyi on 17.06.2020.
//  Copyright © 2020 Roman Kavinskyi. All rights reserved.
//

import UIKit

class Screen1: UIViewController {
	
	private let tableView = UITableView()
	private var jsonDecoder = DecodeJASON()
	var transferredPeople: [PersonModel]? // Copy of the PeopleFromJSON, to keep old changes when I update Screen1
	var transferredPerson: PersonModel?  // The person I updated in Screen 2
	
	private var peopleFromJSON = [PersonModel]()
	var shouldReset = true
	var index: Int?  // Person's position in the PeopleFromJSON array
	
	
	let screen2 = Screen2()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		screen2.delegate = self
		setupTableView()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		navigationController?.isNavigationBarHidden = true
		jsonDecoder.delegate = self
		shouldReset == true ? jsonDecoder.parseJSON() : updateData()
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		navigationController?.isNavigationBarHidden = false
	}
	
	private func updateData() {
		if let person = transferredPerson, let index = index, let transferredPeople = transferredPeople {
			peopleFromJSON = transferredPeople  // Fill the array with previous DATA to be source for TableView
			peopleFromJSON[index] = person  // Change the person in the array with updated version
			shouldReset = true
			tableView.reloadData()
		}
	}
	
	private func setupTableView() {
		view.addSubview(tableView)
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.delegate = self
		tableView.dataSource = self
		tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
		
		tableView.rowHeight = 95
		
		NSLayoutConstraint.activate([
			tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 88),
			tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50)
		])
	}
	
	
	
}

extension Screen1: UITableViewDelegate {
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		screen2.setName = peopleFromJSON[indexPath.row].name
		screen2.setEmail = peopleFromJSON[indexPath.row].email
		screen2.setPhone = peopleFromJSON[indexPath.row].phone
		screen2.indexPath = indexPath.row
		screen2.transferredPeople = peopleFromJSON
		
		navigationController?.pushViewController(screen2, animated: true)
		tableView.deselectRow(at: indexPath, animated: false)
		
		
	}
	
}

extension Screen1: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return peopleFromJSON.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as! TableViewCell
		let person = peopleFromJSON[indexPath.row]
		cell.name.text = person.name
		cell.email.text = person.email
		cell.phone.text = person.phone
		
		
		return cell
	}
	
	
}

extension Screen1: NetworkManagerDelegate {
	func didUpdateData(people: [PersonModel]) {
		peopleFromJSON = people
		tableView.reloadData()
	}
	
	func didFailWithError(error: Error) {
		DispatchQueue.main.async {
			let alert = UIAlertController(title: "Ooops! An Error!", message: error.localizedDescription, preferredStyle: .alert)
			let action = UIAlertAction(title: "OK", style: .default, handler: nil)
			alert.addAction(action)
			self.present(alert, animated: true)
		}
	}
}

extension Screen1: PassData {
	func passData(person: PersonModel, index: Int?, shouldReset: Bool, people: [PersonModel]?) {
		transferredPerson = person
		transferredPeople = people
		self.index = index
		self.shouldReset = shouldReset
		
	}
	
	
}
