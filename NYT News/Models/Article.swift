//
//  Article.swift
//  NYT News
//
//  Created by Muhammad Yusuf  on 12/01/22.
//

import Foundation

/// A type for New York Times article.
struct Article {
    /// Title of the article.
    let title: String
    
    /// Short text containing abstract of the article.
    let abstract: String
    
    /// String URL of the article.
    let url: String
    
    /// Publication date of the article.
    let publishedDate: Date
    
    /// URL of the article.
    var articleURL: URL? {
        URL(string: url)
    }
}

extension Article: Codable {}
extension Article: Identifiable {
    var id: String { url }
}

/// Extension for providing preview data for Article.
extension Article {
    static var previewData: [Article] {
        let previewDataURL = Bundle.main.url(forResource: "MostPopularHome", withExtension: "json")!
        
        let data = try! Data(contentsOf: previewDataURL)
        
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .iso8601
        
        let apiResponse = try! jsonDecoder.decode(NYTAPIResponse.self, from: data)
        
        return apiResponse.results ?? []
    }
}
