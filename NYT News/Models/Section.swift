//
//  Section.swift
//  NYT News
//
//  Created by Muhammad Yusuf  on 12/01/22.
//

import Foundation

enum Section: String {
    case arts
    case automobiles
    case books
    case business
    case fashion
    case food
    case health
    case home
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
    case tMagazine
    case travel
    case upshot
    case us
    case world
    
    var sectionName: String {
        if self == .tMagazine {
            return "t-magazine"
        }
        return rawValue.lowercased()
    }
}
