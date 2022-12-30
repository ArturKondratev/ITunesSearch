//
//  AppDetailScreenshotsViewController.swift
//  iOSArchitecturesDemo
//
//  Created by Артур Кондратьев on 13.12.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import UIKit

class AppDetailScreenshotsViewController: UIViewController {
    
    // MARK: - Private Properties
    private let app: ITunesApp
    private let imageDownloader = ImageDownloader()
    private var appDetailScreenshotView: AppDetailScreenshotsView {
        return self.view as! AppDetailScreenshotsView
    }
    
    //MARK: - Init
    init(app: ITunesApp) {
        self.app = app
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lyfecycle
    override func loadView() {
        self.view = AppDetailScreenshotsView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fillData()
    }
    
    //MARK: - Private
    private func fillData() {
        appDetailScreenshotView.collectionView.delegate = self
        appDetailScreenshotView.collectionView.dataSource = self
    }
}

//MARK: - UICollectionViewDelegateFlowLayout, UICollectionViewDataSource
extension AppDetailScreenshotsViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = AppDetailConstants.getOptimalSize()
        return CGSize(width: size.width, height: size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return app.screenshotUrls.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ScreenshotsCell.reuseId, for: indexPath) as? ScreenshotsCell else { return UICollectionViewCell() }
        let url = app.screenshotUrls[indexPath.row]
        self.imageDownloader.getImage(fromUrl: url) { image, _ in
            cell.configure(image: image!)
        }
        return cell
    }
}
