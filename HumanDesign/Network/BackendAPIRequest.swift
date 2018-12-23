//
//  BackendAPIRequest.swift
//  HumanDesign
//
//  Created by Pavlo Kharambura on 12/23/18.
//  Copyright © 2018 Pavlo Kharambura. All rights reserved.
//

import Foundation

protocol BackendAPIRequest {
    var endpoint: String { get }
    var method: NetworkService.Method { get }
    var parameters: [String: Any]? { get }
    var headers: [String: String]? { get }
}

protocol ParsedItem: class {
    
}

protocol BackendAPIUploadRequest: BackendAPIRequest {
    var uploadData: Data? { get }
}

extension BackendAPIRequest {
    
    func defaultJSONHeaders() -> [String: String] {
        return [:]
    }
    
    func userJSONHeaders(userName: String, authenticationToken: String) -> [String: String] {
        return [:]
    }
}
