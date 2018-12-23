//
//  InternetRechability.swift
//  HumanDesign
//
//  Created by Pavlo Kharambura on 12/23/18.
//  Copyright © 2018 Pavlo Kharambura. All rights reserved.
//

import Foundation

import SystemConfiguration

open class InternetReachability {
    
    class func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        //        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
        //            SCNetworkReachabilityCreateWithAddress(nil, UnsafePointer($0))
        //        }
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
}
