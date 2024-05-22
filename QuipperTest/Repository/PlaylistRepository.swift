//
//  PlaylistRepository.swift
//  QuipperTest
//
//  Created by Rahman Bramantya on 23/05/24.
//

import Foundation

protocol PlaylistRepositoryProtocol {
    func fetchPlaylistData() async -> [PlaylistModel]?
}

class PlaylistRepository: PlaylistRepositoryProtocol {
    func fetchPlaylistData() async -> [PlaylistModel]? {
        return [PlaylistModel()]
    }
}
