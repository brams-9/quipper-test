//
//  QuipperTestTests.swift
//  QuipperTestTests
//
//  Created by Rahman Bramantya on 23/05/24.
//

import XCTest
@testable import QuipperTest

class MockURLProtocol: URLProtocol {
    static var requestHandler: ((URLRequest) throws -> (HTTPURLResponse, Data))?
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        guard let handler = MockURLProtocol.requestHandler else {
            fatalError("Request handler is not set.")
        }
        
        do {
            let (response, data) = try handler(request)
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            client?.urlProtocol(self, didLoad: data)
            client?.urlProtocolDidFinishLoading(self)
        } catch {
            client?.urlProtocol(self, didFailWithError: error)
        }
    }
    
    override func stopLoading() {}
}



final class QuipperTestTests: XCTestCase {
    
    var service: PlaylistRestAPIService?


    override func setUpWithError() throws {
        try super.setUpWithError()
        
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: config)
        
        service = PlaylistRestAPIService(urlSession: session)
    }

    override func tearDownWithError() throws {
        service = nil
        try super.tearDownWithError()
    }

    func testFetchPlaylistDataSuccess() async {
        let jsonString = """
        [
          {
            "title": "G12 Chemistry",
            "presenter_name": "Kaoru Sakata",
            "description": "90 seconds exercise for Chemistry",
            "thumbnail_url": "https://quipper.github.io/native-technical-exam/images/sakata.jpg",
            "video_url": "https://quipper.github.io/native-technical-exam/videos/sakata.mp4",
            "video_duration": 97000
          }
        ]
        """
        let jsonData = jsonString.data(using: .utf8)!
        
        // Set up the mock response handler
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, jsonData)
        }
        
        // Perform the test
        let result = await service?.fetchPlaylistData()
        switch result {
        case .success(let playlists):
            XCTAssertEqual(playlists.count, 1)
            XCTAssertEqual(playlists.first?.title, "G12 Chemistry")
        case .failure(let error):
            XCTFail("Expected success but got failure with error \(error)")
        case .none:
            XCTFail("Expected success but got failure with error")
        }
    }

}
