//
//  ReachabilityCheck.swift
//  LastFM
//
//  Created by Valerii Petrychenko on 7/21/20.
//  Copyright © 2020 Valerii. All rights reserved.
//

import Network

final class ReachabilityCheck {
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "Monitor")
    private var isReachable: InternetState = .on
    static let shared = ReachabilityCheck()
    private init() {}
    
    func configure() {
        monitor.start(queue: queue)
        
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                print("We're connected!")
                self.isReachable = .on
            } else {
                print("No connection.")
                self.isReachable = .off
            }
        }
    }
    
    func canAccess() -> InternetState {
        return isReachable
    }
}
