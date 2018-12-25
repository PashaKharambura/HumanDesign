//
//  Extentions.swift
//  HumanDesign
//
//  Created by Pavlo Kharambura on 12/17/18.
//  Copyright © 2018 Pavlo Kharambura. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    static let greyPurple = UIColor(red: 31/255, green: 7/255, blue: 37/255, alpha: 1)
    static let greenFigure = UIColor(rgb: 0xbdfca4)
    static let yellowFigure = UIColor(rgb: 0xfffdbc)
    static let redFigure = UIColor(rgb: 0xfca4a4)
    static let brownFigure = UIColor(rgb: 0xdbb58c)
    static let purpleLine = UIColor(rgb: 0x531B93)
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}

import UIKit
import AudioToolbox

extension UIViewController {
    
    func showSimpleAlert(title: String, text: String, action: UIAlertAction? = nil) {
        let alertVC = UIAlertController(title: title, message: text, preferredStyle: .alert)
        if let action = action {
            alertVC.addAction(action)
        } else {
            let closeAction = UIAlertAction(title: "Ок", style: .destructive) { (action) in
                alertVC.dismiss(animated: true, completion: nil)
            }
            alertVC.addAction(closeAction)
        }
        self.present(alertVC, animated: true) {
            let peek = SystemSoundID(1519)
            AudioServicesPlaySystemSound(peek)
        }
    }
}

extension UIImageView {
    func setImageColor(color: UIColor) {
        let templateImage = self.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        self.image = templateImage
        self.tintColor = color
    }
}


public func isValidEmail(testStr:String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailTest.evaluate(with: testStr)
}
