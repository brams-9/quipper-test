//
//  PlaylistModel.swift
//  QuipperTest
//
//  Created by Rahman Bramantya on 23/05/24.
//

import Foundation

struct PlaylistModel {
    var title: String?
    var presenterName: String?
    var description: String?
    var thumbnailURL: URL?
    var videoURL: URL?
    var videoDuration: Int?
    
    func formatMilliseconds() -> String {
        let seconds = (videoDuration ?? 0) / 1000
        let minutes = seconds / 60
        let remainingSeconds = seconds % 60
        
        return "\(minutes) minutes \(remainingSeconds) seconds"
    }
}
