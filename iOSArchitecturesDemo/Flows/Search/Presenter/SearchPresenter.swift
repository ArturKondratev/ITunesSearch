//
//  SearchPresenter.swift
//  iOSArchitecturesDemo
//
//  Created by Артур Кондратьев on 26.12.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import Foundation
import UIKit

protocol SearchViewOutput: AnyObject {
    func viewDidSearchApp(with query: String)
    func viewDidSearchSong(with query: String)
    func viewDidSelectApp(_ app: ITunesApp)
    func viewDidSelectSong(_ song: ITunesSong)
    func segmentChanged(with mode: SearchMode)
}

final class SearchPresenter {
    
    //MARK: - Properties
    weak var viewInput: (UIViewController & SearchViewInput)?
    
    //MARK: - Private properties
    private let searchService = ITunesSearchService()
    private var imageServise = ImageDownloader()
    
    //MARK: - Private functions
    private func requestApps(with query: String) {
        self.searchService.getApps(forQuery: query) { [weak self] result in
            guard let self = self else { return }
            self.viewInput?.throbber(show: false)
            result
                .withValue { apps in
                    guard !apps.isEmpty else {
                        self.viewInput?.showNoResults()
                        return
                    }
                    self.viewInput?.hideNoResults()
                    self.viewInput?.searchResultsApp = apps
                }
                .withError {
                    self.viewInput?.showError(error: $0)
                }
        }
    }
    
    private func requestSongs(with query: String) {
        self.searchService.getSongs(forQuery: query) { [weak self] result in
            guard let self = self else { return }
            self.viewInput?.throbber(show: false)
            result
                .withValue { songs in
                    guard !songs.isEmpty else {
                        self.viewInput?.showNoResults()
                        return
                    }
                    self.viewInput?.hideNoResults()
                    self.viewInput?.searchResultsSong = songs
                }
                .withError {
                    self.viewInput?.showError(error: $0)
                }
        }
    }
    
    private func openAppDetails(with app: ITunesApp) {
        let appDetaillViewController = AppDetailViewController(app: app)
        self.viewInput?.navigationController?.pushViewController(appDetaillViewController,
                                                                 animated: true)
    }
    
    private func openSongDetails(with song: ITunesSong) {
        let songDetaillViewController = SongDetailViewController(song: song)
        self.viewInput?.navigationController?.pushViewController(songDetaillViewController,
                                                                 animated: true)
    }
}

//MARK: - SearchViewOutput
extension SearchPresenter: SearchViewOutput {
    
    func viewDidSearchApp(with query: String) {
        self.viewInput?.throbber(show: true)
        self.requestApps(with: query)
    }
    
    func viewDidSearchSong(with query: String) {
        self.viewInput?.throbber(show: true)
        self.requestSongs(with: query)
    }
    
    func viewDidSelectApp(_ app: ITunesApp) {
        self.openAppDetails(with: app)
    }
    
    func viewDidSelectSong(_ song: ITunesSong) {
        self.openSongDetails(with: song)
    }
    
    func segmentChanged(with mode: SearchMode) {
        self.viewInput?.changeMode(with: mode)
    }
}

