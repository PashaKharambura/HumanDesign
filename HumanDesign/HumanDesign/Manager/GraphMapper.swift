//
//  GraphMapper.swift
//  HumanDesign
//
//  Created by Pavlo Kharambura on 12/23/18.
//  Copyright © 2018 Pavlo Kharambura. All rights reserved.
//

import Foundation

class GraphMapper {
    
    static func mapJSON(json: [String:Any]) -> UserInfo {
        let user = UserInfo()
        user.profile = json["profile"] as? String ?? ""
        user.authority = json["authority"] as? String ?? ""
        user.type = json["type"] as? String ?? ""
        user.definition = json["definition"] as? Int ?? 0
        
        if let gate = json["gate"] as? [String:Any] {
            var pers = [Double]()
            if let p = gate["P"] as? [String] {
                for p in p {
                    pers.append(Double(p)!)
                }
            }
            if let p = gate["P"] as? [String:String] {
                for p in p {
                    pers.append(Double(p.value)!)
                }
            }
            user.personalGates = pers
            var desg = [Double]()
            if let d = gate["D"] as? [String:String] {
                for d in d {
                    desg.append(Double(d.value)!)
                }
            }
            if let d = gate["D"] as? [String] {
                for d in d {
                    desg.append(Double(d)!)
                }
            }
            user.designGates = desg
        }
        
        return user
    }
    
}
