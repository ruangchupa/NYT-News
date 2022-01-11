//
//  NYTAPIResponse.swift
//  NYT News
//
//  Created by Muhammad Yusuf  on 12/01/22.
//

import Foundation

/// A type for New York Times base API response.
struct NYTAPIResponse {
    /// The status of the request (e.g "OK").
    let status: String?
    
    /// Last time the request has been hit and updated.
    let lastUpdated: Date?
    
    /// Results of the request.
    let results: [Article]?
}

extension NYTAPIResponse: Decodable {}
