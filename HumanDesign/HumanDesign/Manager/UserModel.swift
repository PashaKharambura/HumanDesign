//
//  UserModel.swift
//  HumanDesign
//
//  Created by Pavlo Kharambura on 12/18/18.
//  Copyright © 2018 Pavlo Kharambura. All rights reserved.
//

import Foundation

class UserModel {
    
    var country: String = ""
    var city: String = ""
    var birthDay: Int = 0
    var birthMonth: Int = 0
    var birthYear: Int = 0
    var birthMinute: Int = 0
    var birthHour: Int = 0
    var info: UserInfo?
    
}

class UserInfo {
    var profile: String = ""
    var type: String = ""
    var authority: String = ""
    var definition: Int = 0
    var personalGates: [Double] = []
    var designGates: [Double] = []
}
