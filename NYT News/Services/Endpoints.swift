//
//  Endpoints.swift
//  NYT News
//
//  Created by Muhammad Yusuf  on 14/01/22.
//

import Foundation

struct Endpoints {
    static let baseURL = Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as! String
    static func generateTopStoriesURL(from section: Section) -> URL {
        var url = "\(Endpoints.baseURL)/topstories/v2/\(section.rawValue.lowercased()).json"
        
        url += "?api-key=\(Endpoints.apiKey)"
        return URL(string: url)!
    }
    
    static let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as! String
}
