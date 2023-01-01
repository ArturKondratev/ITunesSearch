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
    private var imageServise = ImageDownloader()
    private let interactor: SearchInteractorInput
    private let router: RearchRouterInput
    
    //MARK: - Constructor
    init(interactor: SearchInteractorInput, router: RearchRouterInput) {
        self.interactor = interactor
        self.router = router
    }
    
    //MARK: - Private functions
    private func requestApps(with query: String) {
        self.interactor.requestApps(with: query) { [weak self] result in
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
        self.interactor.requestSongs(with: query) { [weak self] result in
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
        router.openAppDetails(app: app)
    }
    
    private func openSongDetails(with song: ITunesSong) {
        router.openSongDetails(song: song)
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

