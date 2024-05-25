//
//  PlaylistRepositoryTests.swift
//  QuipperTestTests
//
//  Created by Rahman Bramantya on 24/05/24.
//

import XCTest
@testable import QuipperTest


final class PlaylistRepositoryTests: XCTestCase {

    // Mock PlaylistRestAPIService for testing purposes
    class MockPlaylistRestAPIService: PlaylistRestAPIServiceProtocol {
        var shouldReturnSuccessScenario: Bool
        
        init(shouldReturnSuccessScenario: Bool = true) {
            self.shouldReturnSuccessScenario = shouldReturnSuccessScenario
        }

        func fetchPlaylistData() async -> Result<[QuipperTest.PlaylistDataModel], Error> {
            if shouldReturnSuccessScenario {
                return .success([
                    QuipperTest.PlaylistDataModel(title: "Title1", presenterName: "presenter1", description: "desc 1", thumbnailURL: "https:/thumbnail1.com", videoURL: "https:/videoURL1.com", videoDuration: 97000),
                    QuipperTest.PlaylistDataModel(title: "Title2", presenterName: "presenter2", description: "desc 2", thumbnailURL: "https:/thumbnail2.com", videoURL: "https:/videoURL2.com", videoDuration: 97000)
                ])
            }
            
            return .failure(PlaylistServiceError.invalidURL)
        }
    }
    

    func testSuccessFetchPlaylistData() async {
        let mockRestAPIService = MockPlaylistRestAPIService()
        let sut = PlaylistRepository(playlistRestAPIService: mockRestAPIService)

        // Act
        let playlist = await sut.fetchPlaylistData()

        // Assert
        XCTAssertNotNil(playlist)
        XCTAssertEqual(playlist?.count, 2)

        XCTAssertEqual(playlist?[0].title, "Title1")
        XCTAssertEqual(playlist?[0].presenterName, "presenter1")
        XCTAssertEqual(playlist?[0].videoURL, URL(string: "https:/videoURL1.com"))
        XCTAssertEqual(playlist?[0].thumbnailURL, URL(string: "https:/thumbnail1.com"))
        XCTAssertEqual(playlist?[0].formatMilliseconds(), "1 minutes 37 seconds")
        XCTAssertEqual(playlist?[0].description, "desc 1")

        XCTAssertEqual(playlist?[1].title, "Title2")
        XCTAssertEqual(playlist?[1].presenterName, "presenter2")
        XCTAssertEqual(playlist?[1].videoURL, URL(string: "https:/videoURL2.com"))
        XCTAssertEqual(playlist?[1].thumbnailURL, URL(string: "https:/thumbnail2.com"))
        XCTAssertEqual(playlist?[1].formatMilliseconds(), "1 minutes 37 seconds")
        XCTAssertEqual(playlist?[1].description, "desc 2")
    }
    
    func testFailedFetchPlaylistData() async {
        let mockRestAPIService = MockPlaylistRestAPIService(shouldReturnSuccessScenario: false)
        let sut = PlaylistRepository(playlistRestAPIService: mockRestAPIService)

        // Act
        let playlist = await sut.fetchPlaylistData()
        
        // Assert
        XCTAssertNil(playlist)
    }
}
