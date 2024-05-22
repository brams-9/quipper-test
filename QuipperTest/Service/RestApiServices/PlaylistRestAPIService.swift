//
//  PlaylistRestAPIService.swift
//  QuipperTest
//
//  Created by Rahman Bramantya on 23/05/24.
//

import Foundation
protocol PlaylistRestAPIServiceProtocol {
    func fetchPlaylistData() async -> [PlaylistDataModel]?
}

class PlaylistRestAPIService: PlaylistRestAPIServiceProtocol {
    func fetchPlaylistData() async -> [PlaylistDataModel]? {
        return nil
    }
}
