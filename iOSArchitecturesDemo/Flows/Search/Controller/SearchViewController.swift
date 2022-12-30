//
//  ViewController.swift
//  iOSArchitecturesDemo
//
//  Created by ekireev on 14.02.2018.
//  Copyright © 2018 ekireev. All rights reserved.
//

import UIKit

protocol SearchViewInput: AnyObject {
    var searchResultsApp: [ITunesApp] { get set }
    var searchResultsSong: [ITunesSong] { get set }
    func showError(error: Error)
    func showNoResults()
    func hideNoResults()
    func throbber(show: Bool)
    func changeMode(with mode: SearchMode)
}

final class SearchViewController: UIViewController {
    
    // MARK: - Properties
    var searchResultsApp = [ITunesApp]() {
        didSet {
            updateTableView()
        }
    }
    var searchResultsSong = [ITunesSong]() {
        didSet {
            updateTableView()
        }
    }
    var searchMode: SearchMode = .apps {
        didSet {
            self.updateTableView()
        }
    }

    // MARK: - Private Properties
    private var searchView: SearchView {
        return self.view as! SearchView
    }
    private var imageServise = ImageDownloader()
    private let presenter: SearchViewOutput
    
    //MARK: - Construction
    init(presenter: SearchViewOutput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func loadView() {
        super.loadView()
        self.view = SearchView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.searchView.searchBar.delegate = self
        self.searchView.delegate = self
        
        self.searchView.tableView.register(AppCell.self, forCellReuseIdentifier: AppCell.reuseIdentifier)
        self.searchView.tableView.register(SongCell.self, forCellReuseIdentifier: SongCell.reuseIdentifier)
        self.searchView.tableView.delegate = self
        self.searchView.tableView.dataSource = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.throbber(show: false)
    }
    
    // MARK: - Private methods
    private func updateTableView() {
        searchView.tableView.isHidden = false
        searchView.tableView.reloadData()
        searchView.searchBar.resignFirstResponder()
    }
}

//MARK: - UITableViewDataSource
extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch searchMode {
        case .apps:
            return searchResultsApp.count
        case .songs:
            return searchResultsSong.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch searchMode {
        case .apps:
            let dequeuedCell = tableView.dequeueReusableCell(withIdentifier: AppCell.reuseIdentifier, for: indexPath)
            guard let cell = dequeuedCell as? AppCell else {
                return dequeuedCell
            }
            let app = self.searchResultsApp[indexPath.row]
            let cellModel = AppCellModelFactory.cellModel(from: app)
            cell.configure(with: cellModel)
            return cell
            
        case .songs:
            let dequeuedCell = tableView.dequeueReusableCell(withIdentifier: SongCell.reuseIdentifier, for: indexPath)
            guard let cell = dequeuedCell as? SongCell else {
                return dequeuedCell
            }
            let song = searchResultsSong[indexPath.row]
            let cellModel = SongCellModelFactory.getCellModel(model: song)
            cell.configure(model: cellModel)
    
            imageServise.getImage(fromUrl: cellModel.icon ) { image, _ in
                DispatchQueue.main.async {
                    cell.trackImage.image = image
                }
            }
            return cell
        }
    }
}

//MARK: - UITableViewDelegate
extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch searchMode {
        case .apps:
            let app = searchResultsApp[indexPath.row]
            presenter.viewDidSelectApp(app)
        case .songs:
            let song = searchResultsSong[indexPath.row]
            presenter.viewDidSelectSong(song)
        }
    }
}

//MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text else {
            searchBar.resignFirstResponder()
            return
        }
        if query.count == 0 {
            searchBar.resignFirstResponder()
            return
        }
        switch searchMode {
        case .apps:
            presenter.viewDidSearchApp(with: query)
        case .songs:
            presenter.viewDidSearchSong(with: query)
        }
    }
}

//MARK: - SearchViewDelegate
extension SearchViewController: SearchViewDelegate {
    func didSelectSearchMode(with mode: SearchMode) {
        presenter.segmentChanged(with: mode)
    }
}

//MARK: - SearchViewInput
extension SearchViewController: SearchViewInput {
    func throbber(show: Bool) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = show
    }
    
    func showError(error: Error) {
        let alert = UIAlertController(title: "Error", message: "\(error.localizedDescription)", preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(actionOk)
        self.present(alert, animated: true, completion: nil)
    }
    
    func showNoResults() {
        self.searchView.emptyResultView.isHidden = false
    }
    
    func hideNoResults() {
        self.searchView.emptyResultView.isHidden = true
    }
    
    func changeMode(with mode: SearchMode) {
        self.searchMode = mode
    }
}
