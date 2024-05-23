//
//  PlaylistRestAPIService.swift
//  QuipperTest
//
//  Created by Rahman Bramantya on 23/05/24.
//

import Foundation
protocol PlaylistRestAPIServiceProtocol {
    func fetchPlaylistData() async -> Result<[PlaylistDataModel], Error>
}

enum PlaylistServiceError: Error {
    case invalidURL
    case networkError(Error)
    case decodingError(Error)
}

class PlaylistRestAPIService: PlaylistRestAPIServiceProtocol {
    var urlSession: URLSession
    init(urlSession: URLSession) {
        self.urlSession = urlSession
        
    }
    func fetchPlaylistData() async -> Result<[PlaylistDataModel], Error> {
        let urlString = "https://quipper.github.io/native-technical-exam/playlist.json"
                guard let url = URL(string: urlString) else {
                    return .failure(PlaylistServiceError.invalidURL)
                }
                
                do {
                    let (data, _) = try await urlSession.data(from: url)
                    
                    let playlistData = try JSONDecoder().decode([PlaylistDataModel].self, from: data)
                    
                    return .success(playlistData)
                } catch let error as DecodingError {
                    return .failure(PlaylistServiceError.decodingError(error))
                } catch {
                    return .failure(PlaylistServiceError.networkError(error))
                }
            }
}
