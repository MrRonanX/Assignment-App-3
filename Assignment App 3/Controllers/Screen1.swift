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
	private var jsonDecoder = JSONDEcoder()
	var transferredPerson: PersonModel?
	var transferredPeople: [PersonModel]?
	
	private var peopleFromJSON = [PersonModel]()
	var shouldReset = true
	var indexPath: Int?
	
	override func viewDidLoad() {
		super.viewDidLoad()
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
		if let person = transferredPerson, let index = indexPath, let transferredPeople = transferredPeople {
			peopleFromJSON = transferredPeople
			peopleFromJSON[index] = person
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
		
		performSegue(withIdentifier: "ToScreen2", sender: self)
		tableView.deselectRow(at: indexPath, animated: false)
		
		
	}
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		
		if segue.identifier == "ToScreen2", let indexPath = tableView.indexPathForSelectedRow {
			let destinationVC = segue.destination as! Screen2
			destinationVC.setName = peopleFromJSON[indexPath.row].name
			destinationVC.setEmail = peopleFromJSON[indexPath.row].email
			destinationVC.setPhone = peopleFromJSON[indexPath.row].phone
			destinationVC.indexPath = indexPath.row
			destinationVC.transferredPeople = peopleFromJSON
		}
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
