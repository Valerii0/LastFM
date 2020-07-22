//
//  ChangeCountryViewController.swift
//  LastFM
//
//  Created by Valerii Petrychenko on 7/20/20.
//  Copyright © 2020 Valerii. All rights reserved.
//

import UIKit

class ChangeCountryViewController: UIViewController, Storyboarded {
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var countriesTableView: UITableView!
    
    var presenter: ChangeCountryPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    private func setUpUI() {
        setUpView()
        setUpBackButton()
        setUpCountriesTableView()
    }
    
    private func setUpView() {
        self.view.backgroundColor = .clear
        holderView.layer.cornerRadius = ChangeCountryConstants.cornerRadius
    }
    
    private func setUpBackButton() {
        backButton.setTitle(ChangeCountryConstants.backTitle.rawValue, for: .normal)
        backButton.setTitleColor(.blue, for: .normal)
    }
    
    private func setUpCountriesTableView() {
        countriesTableView.delegate = self
        countriesTableView.dataSource = self
        countriesTableView.backgroundColor = .clear
        countriesTableView.tableFooterView = UIView()
        countriesTableView.register(UINib(nibName: ChangeCountryConstants.countriesTableViewCell.rawValue, bundle: nil),
                                    forCellReuseIdentifier: ChangeCountryConstants.countriesTableViewCell.rawValue)
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        presenter.dismiss()
    }
}

extension ChangeCountryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.countriesToShow.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ChangeCountryConstants.countriesTableViewCell.rawValue, for: indexPath) as! countriesTableViewCell
        cell.configure(country: presenter.countriesToShow[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        presenter.changeCountry(index: indexPath.row)
    }
}

extension ChangeCountryViewController: ChangeCountryView {
}
