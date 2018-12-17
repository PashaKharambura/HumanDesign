//
//  ViewController.swift
//  HumanDesign
//
//  Created by Pavlo Kharambura on 12/15/18.
//  Copyright © 2018 Pavlo Kharambura. All rights reserved.
//

import UIKit

class ComputationVC: UIViewController {

    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var month: UILabel!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var view3: UIView!
    
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var view4: UIView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var view5: UIView!
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var view6: UIView!
    
    @IBOutlet weak var checkboxImage: UIImageView!
    
    @IBOutlet weak var countButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialViewConfigurations()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.barTintColor = UIColor.greyPurple
    }

    private func initialViewConfigurations() {
        configureBgViews()
    }
    
    private func configureBgViews() {
        let views = [view1,view2,view3,view4,view5,view6,countButton]
        for view in views {
            view?.layer.cornerRadius = 25
        }
    }
    
    @IBAction func ButtonAction(_ sender: Any) {
        performSegue(withIdentifier: "HumanDesignSegue", sender: nil)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
}

