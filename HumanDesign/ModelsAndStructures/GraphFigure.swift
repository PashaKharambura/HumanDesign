//
//  GraphFigure.swift
//  HumanDesign
//
//  Created by Pavlo Kharambura on 12/24/18.
//  Copyright © 2018 Pavlo Kharambura. All rights reserved.
//

import Foundation
import UIKit

class GraphFigure {
    var image: UIImageView
    var numbers: [Int]
    
    init(image: UIImageView, numbers: [Int]) {
        self.image = image
        self.numbers = numbers
    }
}
