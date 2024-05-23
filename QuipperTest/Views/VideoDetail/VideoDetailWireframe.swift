//
//  VideoDetailWireframe.swift
//  QuipperTest
//
//  Created by Rahman Bramantya on 23/05/24.
//

import Foundation

import Foundation
import UIKit

class VideoDetailWiframe {
    private var videoDetailViewController: UIViewController
    
    init() {
        videoDetailViewController = VideoDetailViewController()
    }
    
    func getViewController(playlistData data: PlaylistModel) -> UIViewController {
        guard let vc = videoDetailViewController as? VideoDetailViewController else {return VideoDetailViewController()}
        vc.playlistData = data
        return vc
    }
}
