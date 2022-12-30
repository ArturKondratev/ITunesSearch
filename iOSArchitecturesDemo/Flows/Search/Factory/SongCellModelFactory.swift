//
//  SongCellModelFactory.swift
//  iOSArchitecturesDemo
//
//  Created by Артур Кондратьев on 16.12.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import Foundation

struct SongModel {
    let artistName: String
    let trackname: String
    let icon: String
}

class SongCellModelFactory {
    
    static func getCellModel(model: ITunesSong) -> SongModel {
        return SongModel(artistName: model.artistName ?? "",
                         trackname: model.trackName,
                         icon: model.smallArtwork ?? "")
    }
}
