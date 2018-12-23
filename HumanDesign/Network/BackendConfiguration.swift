//
//  BackendConfiguration.swift
//  HumanDesign
//
//  Created by Pavlo Kharambura on 12/23/18.
//  Copyright © 2018 Pavlo Kharambura. All rights reserved.
//

import Foundation

final class BackendConfiguration {
    
    let baseURL: URL
    
    init(baseURL url: URL) {
        self.baseURL = url
    }
    
    static var shared: BackendConfiguration!
}
