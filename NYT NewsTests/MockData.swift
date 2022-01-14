//
//  MockData.swift
//  NYT NewsTests
//
//  Created by Muhammad Yusuf  on 14/01/22.
//

import Foundation

class MockData {
    static let topStoriesHomeSuccessJSON: URL = Bundle(for: MockData.self)
        .url(forResource: "TopStoriesHome_SuccessResponse", withExtension: "json")!
    static let topStoriesHomeNoAPIKeyJSON: URL = Bundle(for: MockData.self)
        .url(forResource: "TopStoriesHome_NoAPIKeyResponse", withExtension: "json")!
}

internal extension URL {
    /// Returns a `Data` representation of the current `URL`. Force unwrapping as it's only used for tests.
    var data: Data {
        return try! Data(contentsOf: self)
    }
}
