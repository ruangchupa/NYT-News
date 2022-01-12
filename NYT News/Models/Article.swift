//
//  Article.swift
//  NYT News
//
//  Created by Muhammad Yusuf  on 12/01/22.
//

import Foundation

fileprivate let relativeDateFormatter = RelativeDateTimeFormatter()

/// A type for New York Times article.
struct Article {
    /// Title of the article.
    let title: String
    
    /// Short text containing abstract of the article.
    let abstract: String
    
    /// String URL of the article.
    let url: String
    
    let multimedia: [Multimedia]?
    
    /// Publication date of the article.
    let publishedDate: Date
    
    /// URL of the article.
    var articleURL: URL? {
        URL(string: url)
    }
    
    var articleMultimediaURL: URL? {
        if let multimedia = multimedia {
            return URL(string: multimedia[0].url)
        } else {
            return nil
        }
    }
    
    var relativePublicationTime: String {
        relativeDateFormatter.localizedString(for: publishedDate, relativeTo: Date())
    }
}

extension Article: Codable {}
extension Article: Equatable {
    static func ==(lhs: Article, rhs: Article) -> Bool {
        return lhs.url == rhs.url
    }
}
extension Article: Identifiable {
    var id: String { url }
}

/// Extension for providing preview data for Article.
extension Article {
    static var previewData: [Article] {
        let previewDataURL = Bundle.main.url(forResource: "MostPopularHomeJSON", withExtension: "json")!
        
        let data = try! Data(contentsOf: previewDataURL)
        
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .iso8601
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let apiResponse = try! jsonDecoder.decode(NYTAPIResponse<Article>.self, from: data)
        
        return apiResponse.results ?? []
    }
}
