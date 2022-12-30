//
//  AppDetailScreenshotsView.swift
//  iOSArchitecturesDemo
//
//  Created by Артур Кондратьев on 13.12.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import UIKit

class AppDetailScreenshotsView: UIView {
      
    // MARK: - Subviews
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 25.0)
        label.text = "Предпросмотр"
        return label
    }()
    
    private(set) var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .white
        collectionView.register(ScreenshotsCell.self, forCellWithReuseIdentifier: ScreenshotsCell.reuseId)
        return collectionView
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUI()
    }
    
    // MARK: - UI
    private func setUI() {
        self.addSubview(titleLabel)
        self.addSubview(collectionView)
        setConstraints()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 12.0),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: AppDetailConstants.leftIndent),
            
            collectionView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 12.0),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor, constant: AppDetailConstants.leftIndent),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor, constant: AppDetailConstants.rightIndent),
            collectionView.heightAnchor.constraint(equalToConstant: AppDetailConstants.getOptimalSize().height)
        ])
    }
}
