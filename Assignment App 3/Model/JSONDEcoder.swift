//
//  NetworkManager.swift
//  Assignment App 2
//
//  Created by Roman Kavinskyi on 17.06.2020.
//  Copyright © 2020 Roman Kavinskyi. All rights reserved.
//

import Foundation

protocol NetworkManagerDelegate {
	func didUpdateData(people: [PersonModel])
	func didFailWithError(error: Error)
}

struct JSONDEcoder {

	var delegate: NetworkManagerDelegate?
	
	func parseJSON() {
		let decoder = JSONDecoder()
		if let path = Bundle.main.path(forResource: "data", ofType: "json") {
			do {
				let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
				//let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
				
				let decodedData = try decoder.decode([PersonData].self, from: data)
				var people = [PersonModel]()
				
				for person in decodedData {
					let name = person.name
					let email = person.email
					let phone = person.phone
					
					let personModel = PersonModel(name: name, email: email, phone: phone)
					people.append(personModel)
				}
				
				delegate?.didUpdateData(people: people)
			} catch {
				delegate?.didFailWithError(error: error)
			}
		}

	}
	
}
