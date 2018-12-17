//
//  FindLoveVC.swift
//  HumanDesign
//
//  Created by Pavlo Kharambura on 12/16/18.
//  Copyright © 2018 Pavlo Kharambura. All rights reserved.
//

import UIKit

class FindLoveVC: UIViewController {

    private enum ViewState {
        case getReport
        case vaitReport
    }
    
    @IBOutlet weak var peoplesImageView: UIImageView!
    @IBOutlet weak var getReportButton: UIButton!
    @IBOutlet weak var tfBgView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var okImageView: UIImageView!
    @IBOutlet weak var secondTitle: UILabel!
    @IBOutlet weak var secondSubtitle: UILabel!
    
    
    private var viewState: ViewState = .getReport
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setInitialViewConfigurations()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.barTintColor = UIColor.greyPurple
    }
    
    private func setInitialViewConfigurations() {
        tfBgView.layer.cornerRadius = 25
        getReportButton.layer.cornerRadius = 25
        setViewElementsActive(state: .getReport)
    }
    
    private func setViewElementsActive(state: ViewState) {
        switch state {
        case .getReport:
            peoplesImageView.isHidden = false
            tfBgView.isHidden = false
            secondTitle.isHidden = true
            okImageView.isHidden = true
            getReportButton.setTitle("Заказать расчет", for: .normal)
            
            return
        case .vaitReport:
            peoplesImageView.isHidden = true
            tfBgView.isHidden = true
            secondTitle.isHidden = false
            okImageView.isHidden = false
            getReportButton.setTitle("Рассчитать бодиграф", for: .normal)
            
            return
        }
    }
    
    @IBAction func buttonAtion(_ sender: Any) {
            if viewState == .getReport {
                viewState = .vaitReport
            } else {
                viewState = .getReport
            }
            setViewElementsActive(state: viewState)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}
