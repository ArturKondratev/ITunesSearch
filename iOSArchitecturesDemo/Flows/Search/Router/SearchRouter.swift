//
//  SearchRouter.swift
//  iOSArchitecturesDemo
//
//  Created by Артур Кондратьев on 30.12.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import Foundation
import UIKit

protocol RearchRouterInput {
    func openAppDetails(app: ITunesApp)
    func openAppInItunes(app: ITunesApp)
    func openSongDetails(song: ITunesSong)
}

class SearchRouter: RearchRouterInput {
    
    weak var viewController: UIViewController?
    
    func openAppDetails(app: ITunesApp) {
        let appDetaillViewController = AppDetailViewController(app: app)
        self.viewController?.navigationController?.pushViewController(appDetaillViewController,
                                                                      animated: true)
    }
    
    func openAppInItunes(app: ITunesApp) {
        guard let appUrl = app.appUrl, let url = URL(string: appUrl) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    func openSongDetails(song: ITunesSong) {
        let songDetaillViewController = SongDetailViewController(song: song)
        self.viewController?.navigationController?.pushViewController(songDetaillViewController,
                                                                      animated: true)
    }
    
}
