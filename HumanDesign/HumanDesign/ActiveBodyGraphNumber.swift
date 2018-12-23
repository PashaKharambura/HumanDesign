//
//  ActiveBodyGraphNumber.swift
//  HumanDesign
//
//  Created by Dmytro Pasinchuk on 12/22/18.
//  Copyright © 2018 Pavlo Kharambura. All rights reserved.
//

import Foundation
import UIKit

struct ActiveBodyGraphNumber {
    enum NumberColor {
        case red, blue, violet, white
        
        var lineColor: UIColor {
            switch self {
            case .red:
                return UIColor.red
            case .blue:
                return UIColor.blue
            case .violet:
                return UIColor.magenta
            case .white:
                return UIColor.white
            }
        }
    }
    
    let number: Int
    let color:NumberColor
    
    init(number: Int, withColor color: NumberColor) {
        self.number = number
        self.color = color
    }
}
