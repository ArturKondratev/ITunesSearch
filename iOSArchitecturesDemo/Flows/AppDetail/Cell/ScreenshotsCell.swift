//
//  ScreenshotsCell.swift
//  iOSArchitecturesDemo
//
//  Created by Артур Кондратьев on 14.12.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import Foundation
import UIKit

class ScreenshotsCell: UICollectionViewCell {
    
    static let reuseId = "ScreenshotsCell"
    
    // MARK: - Subviews
    private let screenshot: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        return imageView
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.addSubview(screenshot)
        
        NSLayoutConstraint.activate([
            screenshot.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            screenshot.leftAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leftAnchor),
            screenshot.rightAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.rightAnchor),
            screenshot.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.screenshot.image = nil
    }
    
    func configure(image: UIImage) {
        DispatchQueue.main.async {
            self.screenshot.image = image
        }
    }
}
