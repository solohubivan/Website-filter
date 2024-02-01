//
//  NetworkMonitor.swift
//  Website filter
//
//  Created by Ivan Solohub on 28.01.2024.
//

import Foundation
import Network

final class NetworkMonitor {
    static let shared = NetworkMonitor()

    var networkStatusChanged: ((Bool) -> Void)?

    private let queue = DispatchQueue.global()
    private let monitor: NWPathMonitor

    public private(set) var isConnected: Bool = false

    private init() {
        monitor = NWPathMonitor()
    }

    public func startMonitoring() {
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = path.status != .unsatisfied
        }
    }

    public func stopMonitoring() {
        monitor.cancel()
    }
}

