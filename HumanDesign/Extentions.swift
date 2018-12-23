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
