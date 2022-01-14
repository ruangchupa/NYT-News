//
//  Section.swift
//  NYT News
//
//  Created by Muhammad Yusuf  on 12/01/22.
//

import Foundation

/// Defines article sections on New York Times.
enum Section: String, CaseIterable {
    case home
    case arts
    case automobiles
    case books
    case business
    case fashion
    case food
    case health
    case insider
    case magazine
    case movies
    case obituaries
    case opinion
    case politics
    case realestate
    case science
    case sports
    case sundayreview
    case technology
    case theater
    case tMagazine = "t-magazine"
    case travel
    case upshot
    case us
    case world
    
    /// String preferred for section title on the screen.
    var sectionName: String {
        if self == .realestate {
            return "Real Estate"
        }
        if self == .sundayreview {
            return "Sunday Review"
        }
        return rawValue.capitalized
    }
}

extension Section: Identifiable {
    var id: Self { self }
}
