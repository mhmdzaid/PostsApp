//
//  Reachability.swift
//  Core
//
//  Created by Mohamed Elmalhey on 21/09/2025.
//

import Foundation
import Network
public final class Reachability {
    public static let shared = Reachability()

    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "ReachabilityMonitor")

    public private(set) var isConnected: Bool = true

    private init() {
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = (path.status == .satisfied) && (path.usesInterfaceType(.wifi) || path.usesInterfaceType(.cellular))
        }
        monitor.start(queue: queue)
    }

    func stopMonitoring() {
        monitor.cancel()
    }
}
