//
//  NYTAPI.swift
//  NYT News
//
//  Created by Muhammad Yusuf  on 12/01/22.
//

import Foundation

struct NYTAPI {
    static let shared = NYTAPI()
    private init() {}
    
    private let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as! String
    private let baseURL = Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as! String
    
    private let session = URLSession.shared
    private let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()
    
    func fetch(from section: Section = .home) async throws -> [Article] {
        try await fetchArticles(from: generateTopStoriesURL(from: section))
    }
    
    private func fetchArticles(from url: URL) async throws -> [Article] {
        let (data, response) = try await session.data(from: url)
        
        guard let response = response as? HTTPURLResponse else {
            throw generateError(description: "Bad Response")
        }
        
        switch response.statusCode {
            
        case (200...299):
            let apiResponse = try jsonDecoder.decode(NYTAPIResponse<Article>.self, from: data)
            if apiResponse.status == "OK" {
                return apiResponse.results ?? []
            } else {
                throw generateError(description: "An error occured")
            }
        case (400...499):
            throw generateError(description: "Client request error")
        default:
            throw generateError(description: "Server error")
        }
    }
    
    private func generateError(code: Int = 1, description: String) -> Error {
        NSError(domain: "NYTAPI", code: code, userInfo: [NSLocalizedDescriptionKey: description])
    }
    
    private func generateTopStoriesURL(from section: Section) -> URL {
        var url = "\(baseURL)+/topstories/v2/\(section.sectionName).json"
        
        url += "api-key=\(apiKey)"
        return URL(string: url)!
    }
}
