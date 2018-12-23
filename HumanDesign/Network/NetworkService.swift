//
//  NetworkService.swift
//  HumanDesign
//
//  Created by Pavlo Kharambura on 12/23/18.
//  Copyright © 2018 Pavlo Kharambura. All rights reserved.
//

import Foundation

class NetworkService: NSObject, URLSessionDelegate {
    
    var isBusy: Bool {
        return task?.state == .running
    }
    
    private var task: URLSessionDataTask?
    private var successCodes: Range<Int> = 200..<299
    private var failureCodes: Range<Int> = 400..<499
    
    enum Method: String {
        case get, post, put, delete
    }
    
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        let urlCredential = URLCredential(trust: challenge.protectionSpace.serverTrust!)
        completionHandler(.useCredential, urlCredential)
    }
    
    func request(url: URL, method: Method,
                 params: [String: Any]? = nil,
                 headers: [String: String]? = nil,
                 success: ((Data?) -> Void)? = nil,
                 failure: ((_ data: Data?, _ error: NSError?, _ statusCode: Int) -> Void)? = nil) {
        
        let urlComp = NSURLComponents(url: url, resolvingAgainstBaseURL: false)

        var request = URLRequest(url: (urlComp?.url!)!, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0)
        request.timeoutInterval = 6000
        if request.url?.absoluteString == "http://astroapi.ru/api/api.php" {
            request.addValue("application/json", forHTTPHeaderField:"Content-Type")
            //        request.addValue("gzip,deflate", forHTTPHeaderField: "Accept")
        }else{
            request.addValue("application/json; charset=utf-8", forHTTPHeaderField:"Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
        }
        
        
        request.allHTTPHeaderFields = headers
        request.httpMethod = method.rawValue
        
        if let params = params {
            if let rawData = params["raw_data"] {
                request.httpBody = try! JSONSerialization.data(withJSONObject: rawData, options: [])
            }
            else {
                request.httpBody = try! JSONSerialization.data(withJSONObject: params, options: [])
            }
        }
        
        let session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
        
        session.configuration.timeoutIntervalForRequest = 6000
        task = session.dataTask(with: request, completionHandler: { data, response, error in
            let my_url = (urlComp?.url!)!
            print(my_url)
            guard let httpResponse = response as? HTTPURLResponse else {
                failure?(data, error as NSError?, 0)
                return
            }
            
            if let error = error {
                failure?(data, error as NSError?, httpResponse.statusCode)
                return
            }
            
            if self.successCodes.contains(httpResponse.statusCode) {
                NSLog("Request finished with success")
                success?(data)
            } else if self.failureCodes.contains(httpResponse.statusCode) {
                NSLog("Request finished with failure: \(httpResponse.statusCode).")
                failure?(data, error as NSError?, httpResponse.statusCode)
            } else {
                NSLog("Received unexpected status code")
                let info = [
                    NSLocalizedDescriptionKey: "Request failed with code \(httpResponse.statusCode)",
                    NSLocalizedFailureReasonErrorKey: "Wrong handling logic, wrong endpoint mapping or backend bug."
                ]
                let unknownError = NSError(domain: "NetworkService", code: 0, userInfo: info)
                failure?(data, unknownError as NSError?, httpResponse.statusCode)
            }
        })
        
        task?.resume()
    }

    func cancel() {
        task?.cancel()
    }
    
}
