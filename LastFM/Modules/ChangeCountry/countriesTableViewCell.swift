//
//  countriesTableViewCell.swift
//  LastFM
//
//  Created by Valerii Petrychenko on 7/20/20.
//  Copyright © 2020 Valerii. All rights reserved.
//

import UIKit

class countriesTableViewCell: UITableViewCell {
    @IBOutlet weak var countryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpUI()
    }
    
    private func setUpUI() {
        setUpCountryLabel()
    }
    
    private func setUpCountryLabel() {
        countryLabel.textAlignment = .left
        countryLabel.textColor = .black
        countryLabel.numberOfLines = 1
    }
    
    func configure(country: Country) {
        countryLabel.text = country.rawValue
    }
}
