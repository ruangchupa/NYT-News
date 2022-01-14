//
//  NYTAPI.swift
//  NYT News
//
//  Created by Muhammad Yusuf  on 12/01/22.
//

import Foundation

struct NYTAPI {
    let session: URLSession

    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    func fetchTopStories(from section: Section = .home) async throws -> [Article] {
        let url = Endpoints.generateTopStoriesURL(from: section)
        let (data, response) = try await session.data(from: url)
        
        guard let response = response as? HTTPURLResponse else {
            throw generateError(description: "Bad Response")
        }
        
        switch response.status?.responseType {
        case .success:
            let apiResponse = try jsonDecoder.decode(NYTAPIResponse<Article>.self, from: data)
            if apiResponse.status == NYTAPIResponseStatus.ok {
                return apiResponse.results ?? []
            } else {
                throw generateError(description: "An error occured")
            }
        case .clientError:
            throw generateError(description: "Client request error")
        default:
            throw generateError(description: "Server error")
        }
    }
    
    private func generateError(code: Int = 1, description: String) -> Error {
        NSError(domain: "NYTAPI", code: code, userInfo: [NSLocalizedDescriptionKey: description])
    }
}

struct NYTAPIResponseStatus {
    static let ok = "OK"
}
