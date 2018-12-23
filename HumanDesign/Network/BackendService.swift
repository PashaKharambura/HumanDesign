//
//  BackendService.swift
//  HumanDesign
//
//  Created by Pavlo Kharambura on 12/23/18.
//  Copyright © 2018 Pavlo Kharambura. All rights reserved.
//

import Foundation

class BackendService {
    
    private let conf: BackendConfiguration
    private let service: NetworkService = NetworkService()
    var isBusy: Bool {
        return service.isBusy
    }
    
    init(_ coniguration: BackendConfiguration) {
        self.conf = coniguration
    }
    
    init() {
        self.conf = BackendConfiguration(baseURL: BackendService.getApiUrl())
    }
    
    static private func getApiUrl() -> URL {
        let baseURL = URL(string: "http://astroapi.ru/api/api.php")!

        return baseURL
    }
    
    func request(request: BackendAPIRequest,
                 success: ((AnyObject?) -> Void)? = nil,
                 failure: ((NSError) -> Void)? = nil) {
        var component = URLComponents(string: conf.baseURL.absoluteString + request.endpoint)
        if let parameters = request.parameters, request.method == .get {
            var items: [URLQueryItem] = []
            for (key, value) in parameters {
                if let parameter = value as? String {
                    items.append(URLQueryItem(name: key, value: parameter))
                }
            }
            let _ = items.filter{!$0.name.isEmpty}
            if !items.isEmpty {
                component?.queryItems = items
            }
        }
        
        guard let url = component?.url else {
            return
        }
        
        //        let baseURL = conf.baseURL
        //        let url = baseURL.appendingPathComponent(request.endpoint)
        let headers = request.headers
        service.request(url: url, method: request.method, params: request.parameters, headers: headers, success: { data in
            
            var json: AnyObject? = nil
            
            if let data = data {
                if let newJson = try? JSONSerialization.jsonObject(with: data, options: []) as AnyObject {
                    json = newJson
                } else {
                    json = data as? AnyObject
                }
            }
            
            success?(json)
            
            
        }, failure: { data, error, statusCode in
            if let data = data, let json = try? JSONSerialization.jsonObject(with: data, options: []) as AnyObject  {
                var info: [String: String] = [:]
                if let errorJson = json as? [String: Any], let errorMessage = errorJson["message"] as? String {
                    print(errorMessage)
                    info = [
                        NSLocalizedDescriptionKey: errorMessage,
                        NSLocalizedFailureReasonErrorKey: "Probably not allowed action."
                    ]
                } else {
                    info = [
                        NSLocalizedDescriptionKey: json as? String ?? "",
                        NSLocalizedFailureReasonErrorKey: "Probably not allowed action."
                    ]
                }
                let error = NSError(domain: "BackendService", code: 0, userInfo: info)
                failure?(error)
            } else if let data = data, let errorText = String(data: data, encoding: String.Encoding.utf8) {
                let info = [
                    NSLocalizedDescriptionKey: errorText,
                    NSLocalizedFailureReasonErrorKey: "Probably not allowed action."
                ]
                let error = NSError(domain: "BackendService", code: 0, userInfo: info)
                failure?(error)
            } else {
                failure?(error ?? NSError(domain: "BackendService", code: 0, userInfo: nil))
            }
        })
    }
  
    
    func cancel() {
        service.cancel()
    }
}
