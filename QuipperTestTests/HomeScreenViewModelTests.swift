//
//  HomeScreenViewModelTests.swift
//  QuipperTestTests
//
//  Created by Rahman Bramantya on 25/05/24.
//

import XCTest
@testable import QuipperTest

final class HomeScreenViewModelTests: XCTestCase {
    
    fileprivate class MockPlaylistRepository: PlaylistRepositoryProtocol {
        var shouldReturnError = false
        var playlistData: [PlaylistModel] = [
            PlaylistModel(title: "Title1", presenterName: "Presenter1", description: "Description1", thumbnailURL: URL(string: "https://example.com/thumbnail1.jpg"), videoURL: URL(string: "https://example.com/video1.mp4"), videoDuration: 120000),
            PlaylistModel(title: "Title2", presenterName: "Presenter2", description: "Description2", thumbnailURL: URL(string: "https://example.com/thumbnail2.jpg"), videoURL: URL(string: "https://example.com/video2.mp4"), videoDuration: 180000)
        ]

        func fetchPlaylistData() async -> [PlaylistModel]? {
            if shouldReturnError {
                return nil
            } else {
                return playlistData
            }
        }
    }

    var viewModel: HomeScreenViewModel?
    fileprivate var mockRepository: MockPlaylistRepository?

    override func setUp() {
        super.setUp()
        mockRepository = MockPlaylistRepository()
        viewModel = HomeScreenViewModel(playlistRepository: mockRepository!)
    }

    override func tearDown() {
        viewModel = nil
        mockRepository = nil
        super.tearDown()
    }

    func testGetVideoPlaylistSuccess() async {
        // Arrange
        let expectation = self.expectation(description: "onDataUpdate called")
        viewModel?.onDataUpdate = {
            expectation.fulfill()
        }

        // Act
        await viewModel?.getVideoPlaylist()

        // Assert
        await waitForExpectations(timeout: 1.0, handler: nil)
        XCTAssertEqual(viewModel?.videoPlaylists.count, 2)
        XCTAssertEqual(viewModel?.videoPlaylists[0].title, "Title1")
        XCTAssertEqual(viewModel?.videoPlaylists[0].formatMilliseconds(), "2 minutes 0 seconds")
        
        XCTAssertEqual(viewModel?.videoPlaylists[0].title, "Title1")
        XCTAssertEqual(viewModel?.videoPlaylists[0].formatMilliseconds(), "2 minutes 0 seconds")
    }

    func testGetVideoPlaylistFailure() async {
        // Arrange
        mockRepository?.shouldReturnError = true
        let expectation = self.expectation(description: "onDataUpdate called")
        viewModel?.onDataUpdate = {
            expectation.fulfill()
        }

        // Act
        await viewModel?.getVideoPlaylist()

        // Assert
        await waitForExpectations(timeout: 1.0, handler: nil)
        XCTAssertEqual(viewModel?.videoPlaylists.count, 0)
    }
}



