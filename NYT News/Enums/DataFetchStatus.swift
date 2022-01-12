//
//  DataFetchStatus.swift
//  NYT News
//
//  Created by Muhammad Yusuf  on 12/01/22.
//

import Foundation

/// Defining the status of data fetching.
enum DataFetchStatus<T> {
    
    /// The data is fetching
    case fetching
    
    /// The data has been successfully fetched
    case success(T)
    
    /// Error occured when fetching
    case failure(Error)
    
}
