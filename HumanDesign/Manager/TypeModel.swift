//
//  TypeModel.swift
//  HumanDesign
//
//  Created by Pavlo Kharambura on 12/28/18.
//  Copyright © 2018 Pavlo Kharambura. All rights reserved.
//

import Foundation
import UIKit

class TypeModel {
    
    var id: String
    var name: String
    var image: UIImage
    var info: String
    var peoples: String
    
    init(id: String, name: String, image: UIImage, info: String, peoples: String) {
        self.id = id
        self.name = name
        self.image = image
        self.info = info
        self.peoples = peoples
    }
    
}

class ProfileModel {
    
    var id: String
    var name: String
    var image: UIImage
    var info: String
    var peoples: String
    
    init(id: String, name: String, image: UIImage, info: String, peoples: String) {
        self.id = id
        self.name = name
        self.image = image
        self.info = info
        self.peoples = peoples
    }
    
}
