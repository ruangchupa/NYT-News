//
//  NetworkMonitorViewModel.swift
//  NYT News
//
//  Created by Muhammad Yusuf  on 13/01/22.
//

import Foundation
import Network

/// Defining the network status.
enum NetworkStatus: String {
    
    /// Connected to the Internet.
    case connected
    
    /// Disconnected from the Internet.
    case disconnected
}

/// Monitor the connection status on a background thread and
/// publish the connection status on the main thread.
class NetworkMonitorViewModel: ObservableObject {
    @Published var status: NetworkStatus = .connected
    
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "Monitor")

    init() {
        monitor.pathUpdateHandler = { [weak self] path in
            guard let self = self else { return }

            DispatchQueue.main.async {
                if path.status == .satisfied {
                    print("Connected.")
                    self.status = .connected
                } else {
                    print("No connection.")
                    self.status = .disconnected
                }
            }
        }
        monitor.start(queue: queue)
    }
}
