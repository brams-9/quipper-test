//
//  HomeScreenViewModel.swift
//  QuipperTest
//
//  Created by Rahman Bramantya on 23/05/24.
//

import Foundation

protocol HomeScreenViewModelProtocol {
    var onDataUpdate: (() -> Void)? { get set }
    var videoPlaylists: [PlaylistModel] { get }
    func getVideoPlaylist() async
}

class HomeScreenViewModel: HomeScreenViewModelProtocol {
    private var playlistRepository: PlaylistRepositoryProtocol
    var onDataUpdate: (() -> Void)?

    var videoPlaylists: [PlaylistModel] = [] {
        didSet {
            onDataUpdate?()
        }
    }
    
    init(playlistRepository: PlaylistRepositoryProtocol) {
        self.playlistRepository = playlistRepository
    }
    
    func getVideoPlaylist() async {
        videoPlaylists = await playlistRepository.fetchPlaylistData() ?? []
    }
    
}
