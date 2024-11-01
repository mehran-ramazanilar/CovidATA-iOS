//
//  Reachablity.swift
//  CovidATA-Live
//
//  Created by Mehran Ramazanilar on 12/12/20.
//

import SwiftUI
import Foundation
import SystemConfiguration

public class Reachability {

    class func isConnectedToNetwork() -> Bool {

        var zeroAddress = sockaddr_in()
                zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
                zeroAddress.sin_family = sa_family_t(AF_INET)

                guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
                    $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                        SCNetworkReachabilityCreateWithAddress(nil, $0)
                    }
                }) else {
                    return false
                }

                var flags: SCNetworkReachabilityFlags = []
                if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
                    return false
                }
                if flags.isEmpty {
                    return false
                }

                let isReachable = flags.contains(.reachable)
                let needsConnection = flags.contains(.connectionRequired)

                return (isReachable && !needsConnection)
    }

}
