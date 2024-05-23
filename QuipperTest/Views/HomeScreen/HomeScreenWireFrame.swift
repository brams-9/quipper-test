//
//  HomeScreenWireFrame.swift
//  QuipperTest
//
//  Created by Rahman Bramantya on 23/05/24.
//

import Foundation
import UIKit

class HomeScreenWiframe {
    private var playlistRestAPIService: PlaylistRestAPIServiceProtocol
    private var playlistRepository: PlaylistRepositoryProtocol
    private var homeScreenViewModel: HomeScreenViewModelProtocol
    private var homeScreenViewController: UIViewController
    
    init() {
        playlistRestAPIService = PlaylistRestAPIService()
        playlistRepository = PlaylistRepository(playlistRestAPIService: playlistRestAPIService)
        homeScreenViewModel = HomeScreenViewModel(playlistRepository: playlistRepository)
        homeScreenViewController = HomeScreenViewController(viewModel: homeScreenViewModel)
    }
    
    func getViewController() -> UIViewController {
        return homeScreenViewController
    }
}
