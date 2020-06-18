//
//  TableViewCell.swift
//  Assignment App 2
//
//  Created by Roman Kavinskyi on 17.06.2020.
//  Copyright © 2020 Roman Kavinskyi. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
	
	static let identifier = "TableViewCell"
	
	
	
	let name = UILabel()
	let email = UILabel()
	let phone = UILabel()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
		setupCell()
	
		
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

	
	private func setupCell() {
		
		
		addSubview(name)
		name.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			name.topAnchor.constraint(equalTo: topAnchor, constant: 10),
			name.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
			name.heightAnchor.constraint(equalToConstant: 20)
		])
		
		addSubview(email)
		email.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			email.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 10),
			email.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
			email.heightAnchor.constraint(equalToConstant: 20)
		])
		
		addSubview(phone)
		phone.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			phone.topAnchor.constraint(equalTo: email.bottomAnchor, constant: 10),
			phone.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
			phone.heightAnchor.constraint(equalToConstant: 20)
		])
	}

}
