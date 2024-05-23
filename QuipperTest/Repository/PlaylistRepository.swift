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
    private var playlistRestAPIService: PlaylistRestAPIServiceProtocol
    
    init(playlistRestAPIService: PlaylistRestAPIServiceProtocol) {
        self.playlistRestAPIService = playlistRestAPIService
    }
    
    func fetchPlaylistData() async -> [PlaylistModel]? {
        let result = await playlistRestAPIService.fetchPlaylistData()
        switch result {
        case .success(let playlistData):
            return playlistData.map { data in
                PlaylistModel(title: data.title, presenterName: data.presenterName, description: data.description, thumbnailURL: URL(string: data.thumbnailURL), videoURL: URL(string: data.videoURL), videoDuration: data.videoDuration)
            }
        case .failure(_):
            return nil
        }
    }
}
