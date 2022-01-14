//
//  NYTAPIMockedTests.swift
//  NYT NewsTests
//
//  Created by Muhammad Yusuf  on 12/01/22.
//

import XCTest
import Mocker
@testable import NYT_News

class NYTAPIMockedTests: XCTestCase {
    
    var sut: NYTAPI!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockingURLProtocol.self] + (configuration.protocolClasses ?? [])
        let sessionManager = URLSession(configuration: configuration)
        sut = NYTAPI(session: sessionManager)
    }

    override func tearDownWithError() throws {
    }

    func testGetTopStoriesOfHomeSectionWithValidAPIKeyGetsSuccess() async throws {
        // 1. given
        let promise = expectation(description: "Gets success response with articles")
        var articles: [Article]

        let mock = Mock(url: Endpoints.generateTopStoriesURL(from: .home),
                        dataType: .json,
                        statusCode: HTTPStatusCode.ok.rawValue,
                        data: [.get: MockData.topStoriesHomeSuccessJSON.data])
        mock.register()

        // 2. when
        do {
            let results = try await sut.fetchTopStories(from: .home)
            if Task.isCancelled { return }
            articles = results
            XCTAssertEqual(articles.count, 56)
            promise.fulfill()
        } catch {
            if Task.isCancelled { return }
            XCTFail("Error happens")
        }

        // 3. then
        wait(for: [promise], timeout: 5)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
