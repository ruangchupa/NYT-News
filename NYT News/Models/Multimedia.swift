//
//  Multimedia.swift
//  NYT News
//
//  Created by Muhammad Yusuf  on 12/01/22.
//

import Foundation

/// A type for New York Times multimedia.
struct Multimedia {
    /// String URL of the multimedia.
    let url: String
    
    /// URL of the multimedia.
    var mutimediaURL: URL? {
        URL(string: url)
    }
}

extension Multimedia: Codable {}
