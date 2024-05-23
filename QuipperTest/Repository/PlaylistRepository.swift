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
        
        return [
            PlaylistModel(title: "G12 Chemistry", presenterName: "Kaoru Sakata", description: "90 seconds exercise for Chemistry", thumbnailURL: URL(string: "https://quipper.github.io/native-technical-exam/images/sakata.jpg"), videoURL: URL(string: "https://quipper.github.io/native-technical-exam/videos/sakata.mp4"), videoDuration: 97000),
            PlaylistModel(title: "G12 Rando Random Random Random Random", presenterName: "Kaoru Sakata", description: "90 seconds exercise for Chemistry", thumbnailURL: URL(string: "https://quipper.github.io/native-technical-exam/images/sakata.jpg"), videoURL: URL(string: "https://quipper.github.io/native-technical-exam/videos/sakata.mp4"), videoDuration: 97000)
        ]
    }
}
