//
//  SongDetailView.swift
//  iOSArchitecturesDemo
//
//  Created by Артур Кондратьев on 16.12.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import UIKit

protocol SongDetailViewDelegate: AnyObject {
    func playActionButton()
    func sliderDidChanged(value: Float)
}

class SongDetailView: LinearGradientView {
    
    weak var delegate: SongDetailViewDelegate?
    
    // MARK: - Subviews
    private(set) lazy var albomImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        return image
    }()
    
    private(set) lazy var artistNameLable: UILabel = {
        let lable = UILabel()
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.font = UIFont.boldSystemFont(ofSize: 24)
        lable.numberOfLines = 2
        lable.textAlignment = .center
        lable.textColor = .white
        return lable
    }()
    
    private(set) lazy var trackNameLable: UILabel = {
        let lable = UILabel()
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.font = UIFont.boldSystemFont(ofSize: 24)
        lable.numberOfLines = 2
        lable.textAlignment = .center
        lable.textColor = .white
        return lable
    }()
    
    private(set) lazy var slider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.minimumTrackTintColor = .white
        slider.maximumTrackTintColor = .darkGray
        slider.addTarget(self, action: #selector(sliderDidChanged), for: .valueChanged)
        return slider
    }()
    
    private(set) lazy var leftTimeLable: UILabel = {
        let lable = UILabel()
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.font = UIFont.boldSystemFont(ofSize: 14)
        lable.textAlignment = .left
        lable.textColor = .lightGray
        lable.text = "0:00"
        return lable
    }()
    
    private(set) lazy var rightTimeLable: UILabel = {
        let lable = UILabel()
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.font = UIFont.boldSystemFont(ofSize: 14)
        lable.textAlignment = .right
        lable.textColor = .lightGray
        lable.text = "-0.00"
        return lable
    }()
    
    private(set) lazy var playButton: UIButton = {
        let button = CustomButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "play.fill"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(playButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private(set) lazy var forwardButton: UIButton = {
        let button = CustomButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "forward.fill"), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    private(set) lazy var backwardButton: UIButton = {
        let button = CustomButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "backward.fill"), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configureUI()
    }
        
    // MARK: - UI
    private func configureUI() {
        addSubview(albomImage)
        addSubview(artistNameLable)
        addSubview(trackNameLable)
        addSubview(slider)
        addSubview(leftTimeLable)
        addSubview(rightTimeLable)
        
        addSubview(playButton)
        addSubview(forwardButton)
        addSubview(backwardButton)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        let safeArea = self.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            
            self.albomImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            self.albomImage.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 16),
            self.albomImage.heightAnchor.constraint(equalToConstant: 200),
            self.albomImage.widthAnchor.constraint(equalToConstant: 200),
            
            self.artistNameLable.topAnchor.constraint(equalTo: self.albomImage.bottomAnchor, constant: 20),
            self.artistNameLable.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 16),
            self.artistNameLable.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -16),
            
            self.trackNameLable.topAnchor.constraint(equalTo: self.artistNameLable.bottomAnchor, constant: 10),
            self.trackNameLable.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 16),
            self.trackNameLable.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -16),
            
            self.slider.topAnchor.constraint(equalTo: self.trackNameLable.bottomAnchor, constant: 20),
            self.slider.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 16),
            self.slider.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -16),
            self.slider.heightAnchor.constraint(equalToConstant: 10),
            
            self.leftTimeLable.topAnchor.constraint(equalTo: self.slider.bottomAnchor, constant: 10),
            self.leftTimeLable.leftAnchor.constraint(equalTo: self.slider.leftAnchor),
            
            self.rightTimeLable.topAnchor.constraint(equalTo: self.slider.bottomAnchor, constant: 10),
            self.rightTimeLable.rightAnchor.constraint(equalTo: self.slider.rightAnchor),
            
            self.playButton.widthAnchor.constraint(equalToConstant: 50),
            self.playButton.heightAnchor.constraint(equalToConstant: 50),
            self.playButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            self.playButton.topAnchor.constraint(equalTo: self.rightTimeLable.bottomAnchor, constant: 20),
            
            self.forwardButton.centerYAnchor.constraint(equalTo: self.playButton.centerYAnchor),
            self.forwardButton.leftAnchor.constraint(equalTo: self.playButton.rightAnchor, constant: 60),
            self.forwardButton.widthAnchor.constraint(equalToConstant: 50),
            self.forwardButton.heightAnchor.constraint(equalToConstant: 50),
            
            self.backwardButton.centerYAnchor.constraint(equalTo: self.playButton.centerYAnchor),
            self.backwardButton.rightAnchor.constraint(equalTo: self.playButton.leftAnchor, constant: -60),
            self.backwardButton.widthAnchor.constraint(equalToConstant: 50),
            self.backwardButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    //MARK: - Actions
    
    @objc
    private func playButtonPressed() {
        delegate?.playActionButton()
    }
    
    @objc
    private func sliderDidChanged() {
        delegate?.sliderDidChanged(value: slider.value)
    }
}
