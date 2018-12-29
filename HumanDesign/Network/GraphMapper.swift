//
//  GraphMapper.swift
//  HumanDesign
//
//  Created by Pavlo Kharambura on 12/23/18.
//  Copyright © 2018 Pavlo Kharambura. All rights reserved.
//

import Foundation


class GraphMapper {
    
    static let fields = ["SUN", "EARTH", "MOON", "TRUE_NODE", "SOUTH_NODE", "MERCURY", "VENUS", "MARS", "JUPITER", "SATURN", "URANUS", "NEPTUNE", "PLUTO", "CHIRON"]

    
    static func mapJSON(json: [String:Any]) -> UserInfo {
        let user = UserInfo()
        user.profile = json["profile"] as? String ?? ""
        user.authority = json["authority"] as? String ?? ""
        user.type = json["type"] as? String ?? ""
        user.definition = json["definition"] as? Int ?? 0
        
        if let lines = json["canal"] as? [String:String] {
            var myLines = [Int]()
            for line in lines {
                let array = line.value.components(separatedBy: "-")
                myLines.append(contentsOf: array.map{Int($0)!})
            }
            user.superActiveNumbers = Array(Set(myLines))
        }
        if let P = json["P"] as? [String:Any] {
            var pers = [Double]()
            if let data = P["data"] as? [String:Any] {
                for field in fields {
                    if let json = data[field] as? [String:Any] {
                        pers.append(getNumber(from: json))
                    }
                }
                user.personalGates = pers
            }
        }
        if let D = json["D"] as? [String:Any] {
            var desg = [Double]()
            if let data = D["data"] as? [String:Any] {
                for field in fields {
                    if let json = data[field] as? [String:Any] {
                        desg.append(getNumber(from: json))
                    }
                }
                user.designGates = desg
            }
        }
        
        return user
    }
    
    static func getNumber(from json: [String:Any]) -> Double {
        var number = Double()
        if let gate = json["gate"] as? [String:Any] {
            let int = gate["gate"] as? String ?? "0"
            let double = gate["line"] as? Int ?? 0
            
            number = Double(int)! + (Double(double)/10)
        }
        return number
    }
}

//            if let p = gate["P"] as? [String] {
//                for p in p {
//                    pers.append(Double(p)!)
//                }
//            }
//            if let p = gate["P"] as? [String:String] {
//                for p in p {
//                    pers.append(Double(p.value)!)
//                }
//            }

//            if let d = gate["D"] as? [String:String] {
//                for d in d {
//                    desg.append(Double(d.value)!)
//                }
//            }
//            if let d = gate["D"] as? [String] {
//                for d in d {
//                    desg.append(Double(d)!)
//                }
//            }
