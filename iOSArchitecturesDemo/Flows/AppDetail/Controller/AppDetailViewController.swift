//
//  AppDetailViewController.swift
//  iOSArchitecturesDemo
//
//  Created by ekireev on 20.02.2018.
//  Copyright © 2018 ekireev. All rights reserved.
//

import UIKit

final class AppDetailViewController: UIViewController {
    
    // MARK: - Properties
    let app: ITunesApp
    lazy var headerViewController = AppDetailHeaderViewController(app: self.app)
    lazy var whatsNewViewController = AppDetailWhatsNewViewController(app: self.app)
    lazy var screenshotsViewController = AppDetailScreenshotsViewController(app: self.app)
    
    //MARK: - Init
    init(app: ITunesApp) {
        self.app = app
        super.init(nibName: nil, bundle: nil) }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
    }
    
    // MARK: - Private
    private func configureUI() {
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.tintColor = UIColor.white;
        self.navigationItem.largeTitleDisplayMode = .never
        self.addHeaderViewController()
        self.addDescriptionViewController()
        self.addScreenshotsViewController()
    }
    
    private func addHeaderViewController() {
        self.addChild(self.headerViewController)
        self.view.addSubview(self.headerViewController.view)
        self.headerViewController.didMove(toParent: self)
        
        self.headerViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.headerViewController.view.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.headerViewController.view.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.headerViewController.view.rightAnchor.constraint(equalTo: self.view.rightAnchor) ])
    }
    
    private func addDescriptionViewController() {
        self.addChild(whatsNewViewController)
        self.view.addSubview(whatsNewViewController.view)
        self.whatsNewViewController.didMove(toParent: self)
        
        self.whatsNewViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.whatsNewViewController.view.topAnchor.constraint(equalTo: self.headerViewController.view.bottomAnchor),
            self.whatsNewViewController.view.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.whatsNewViewController.view.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.whatsNewViewController.view.heightAnchor.constraint(equalToConstant: 120)
        ])
    }
    
    private func addScreenshotsViewController() {
        self.addChild(screenshotsViewController)
        self.view.addSubview(screenshotsViewController.view)
        self.screenshotsViewController.didMove(toParent: self)
        
        self.screenshotsViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            screenshotsViewController.view.topAnchor.constraint(equalTo: self.whatsNewViewController.view.bottomAnchor, constant: 15.0),
            screenshotsViewController.view.leftAnchor.constraint(equalTo: self.whatsNewViewController.view.leftAnchor),
            screenshotsViewController.view.rightAnchor.constraint(equalTo: self.whatsNewViewController.view.rightAnchor),
            screenshotsViewController.view.heightAnchor.constraint(equalToConstant: 70 + AppDetailConstants.getOptimalSize().height),
        ])
    }
}
