//
//  AppDetailWhatsNewView.swift
//  iOSArchitecturesDemo
//
//  Created by Артур Кондратьев on 11.12.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import UIKit

class AppDetailWhatsNewView: UIView {
    
    // MARK: - Subviews
    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Что нового"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        return label
    }()
    
    private(set) lazy var versionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.font = UIFont.boldSystemFont(ofSize: 15.0)
        return label
    }()
    
    private(set) lazy var versionHistoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "История версий"
        label.textColor = .systemBlue
        label.font = UIFont.boldSystemFont(ofSize: 15.0)
        return label
    }()
    
    private(set) lazy var descriptionLabel: UILabel = {
        let lable = UILabel()
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.numberOfLines = 4
        lable.font = UIFont.systemFont(ofSize: 15)
        return lable
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
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        //backgroundColor = .blue
    }
    
    // MARK: - UI
    private func setUI() {
        self.addSubview(titleLabel)
        self.addSubview(versionLabel)
        self.addSubview(versionHistoryLabel)
        self.addSubview(descriptionLabel)
        setConstraints()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16 ),
            
            versionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            versionLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            
            versionHistoryLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            versionHistoryLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            
            descriptionLabel.topAnchor.constraint(equalTo: versionLabel.bottomAnchor, constant: 10),
            descriptionLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            descriptionLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16)
        ])
    }
}
