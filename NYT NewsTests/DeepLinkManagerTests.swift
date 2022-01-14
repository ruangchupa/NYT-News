//
//  DeepLinkManagerTests.swift
//  NYT NewsTests
//
//  Created by Muhammad Yusuf  on 14/01/22.
//

import XCTest
@testable import NYT_News

class DeepLinkManagerTests: XCTestCase {

    var sut: DeepLinkManager!
    
    override func setUpWithError() throws {
        sut = DeepLinkManager()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDeepLinkWithHomeURLGetsHomeDeepLink() throws {
        // 1. given
        let url = URL(string: "nytnewsapp://nytimes.com")!

        // 2. when
        let deepLink = sut.manage(url: url)

        // 3. then
        switch deepLink {
        case .details(_):
            XCTFail("Going to details when it should be home deeplink.")
        case .home:
            XCTAssert(true)
        case .none:
            XCTFail("No deeplink when it should be home deeplink.")
        }
    }
    
    func testDeepLinkWithDetailURLGetsDetailDeepLink() throws {
        // 1. given
        let url = URL(string: "nytnewsapp://nytimes.com/details?url=https%3A%2F%2Fwww%2Enytimes%2Ecom%2F2022%2F01%2F13%2Fus%2Fpolitics%2Fpresidential%2Ddebates%2Drnc%2Ehtml")!

        // 2. when
        let deepLink = sut.manage(url: url)

        // 3. then
        switch deepLink {
        case .details(let articleURL):
            XCTAssertEqual(articleURL,
                           "https://www.nytimes.com/2022/01/13/us/politics/presidential-debates-rnc.html")
        case .home:
            XCTFail("Go to home when it should be detail page deeplink")
        case .none:
            XCTFail("No deeplink when it should be detail page deeplink.")
        }
    }
    
    func testDeepLinkWithInvalidURLGetsNoDeepLink() throws {
        // 1. given
        let url = URL(string: "www.apple.com")!

        // 2. when
        let deepLink = sut.manage(url: url)

        // 3. then
        XCTAssertNil(deepLink)
    }

    func testPerformanceManageMethod() throws {
        let url = URL(string: "nytnewsapp://nytimes.com/details?url=https%3A%2F%2Fwww%2Enytimes%2Ecom%2F2022%2F01%2F13%2Fus%2Fpolitics%2Fpresidential%2Ddebates%2Drnc%2Ehtml")!

        self.measure {
            _ = sut.manage(url: url)
        }
    }

}
