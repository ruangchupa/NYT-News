//
//  DeepLinkManager.swift
//  NYT News
//
//  Created by Muhammad Yusuf  on 14/01/22.
//

import Foundation
import SwiftUI

class DeepLinkManager {
    enum DeepLink: Equatable {
        case home
        case details(reference: String)
    }
    
    func manage(url: URL) -> DeepLink? {
        guard url.scheme == URL.appScheme else { return nil }
        guard url.pathComponents.contains(URL.appDetailsPath) else { return .home }
        guard let query = url.query else { return nil }

        let components = query.split(separator: ",").flatMap { $0.split(separator: "=") }
        guard let idIndex = components.firstIndex(of: Substring(URL.appReferenceQueryName)) else { return nil }
        guard idIndex + 1 < components.count else { return nil }
        guard let decodedURLReference = String(components[idIndex.advanced(by: 1)]).decodeUrl() else { return nil }
        return .details(reference: decodedURLReference)
    }
}

struct DeepLinkKey: EnvironmentKey {
    static var defaultValue: DeepLinkManager.DeepLink? {
        return nil
    }
}

extension EnvironmentValues {
    var deepLink: DeepLinkManager.DeepLink? {
        get {
            self[DeepLinkKey]
        }
        set {
            self[DeepLinkKey] = newValue
        }
    }
}
