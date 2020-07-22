//
//  TopArtistsViewController.swift
//  LastFM
//
//  Created by Valerii Petrychenko on 7/20/20.
//  Copyright © 2020 Valerii. All rights reserved.
//

import UIKit

class TopArtistsViewController: UIViewController, Storyboarded {
    @IBOutlet weak var topArtistsTableView: UITableView!
    
    var presenter: TopArtistsPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    private func setUpUI() {
        setUpView()
        setUpCountryButton()
        setUpTopArtistsTableView()
    }
    
    private func setUpView() {
        self.navigationItem.title = TopArtistsConstants.title.rawValue
    }
    
    private func setUpCountryButton() {
        let infoButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(countryButtonTapped(sender:)))
        navigationItem.rightBarButtonItem = infoButton
    }
    
    @objc private func countryButtonTapped(sender: UIBarButtonItem) {
        presenter.presentChangeCountryViewController()
    }
    
    private func setUpTopArtistsTableView() {
        topArtistsTableView.delegate = self
        topArtistsTableView.dataSource = self
        topArtistsTableView.backgroundColor = .clear
        topArtistsTableView.tableFooterView = UIView()
        topArtistsTableView.register(UINib(nibName: TopArtistsConstants.topArtistTableViewCell.rawValue, bundle: nil),
                                     forCellReuseIdentifier: TopArtistsConstants.topArtistTableViewCell.rawValue)
    }
}

extension TopArtistsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.artistsToShow.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TopArtistsConstants.topArtistTableViewCell.rawValue, for: indexPath) as! TopArtistTableViewCell
        cell.configure(artist: presenter.artistsToShow[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return TopArtistsConstants.topArtistTableViewCellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        presenter.pushArtistViewController(index: indexPath.row)
    }
}

extension TopArtistsViewController: TopArtistsView {
    func reloadInfo(country: Country) {
        DispatchQueue.main.async {
            self.navigationItem.title = TopArtistsConstants.title.rawValue + country.rawValue
            self.topArtistsTableView.reloadData()
        }
    }
}
