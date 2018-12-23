//
//  BodyGraphAPIRequest.swift
//  HumanDesign
//
//  Created by Pavlo Kharambura on 12/23/18.
//  Copyright © 2018 Pavlo Kharambura. All rights reserved.
//

import Foundation

class BodyGraphAPIRequest: BackendAPIRequest {
        
    private let day: Int
    private let month: Int
    private let year: Int
    private let hour: Int
    private let minute: Int

    init(day: Int, month: Int, year: Int, hour: Int, minute: Int) {
        self.day = day
        self.month = month
        self.year = year
        self.hour = hour
        self.minute = minute
    }
    var endpoint: String {
        return "?d=\(String(format: "%02d",self.day))&m=\(String(format: "%02d",self.month))&y=\(self.year)&h=\(String(format: "%02d",self.hour))&mi=\(String(format: "%02d", self.minute))&type=1&link=0&format=json&key=promogeneral&data=bodymini"
    }
    
    var method: NetworkService.Method {
        return .post
    }
    
    var parameters: [String: Any]? {
        return nil
    }
    
    var headers: [String: String]? {
        return nil
    }
}
