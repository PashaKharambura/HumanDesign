
//
//  PersonalMapVC.swift
//  HumanDesign
//
//  Created by Pavlo Kharambura on 12/16/18.
//  Copyright © 2018 Pavlo Kharambura. All rights reserved.
//

import UIKit



class PersonalMapVC: UIViewController {

    private enum ViewState {
        case getReport
        case vaitReport
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var chartsImageView: UIImageView!
    @IBOutlet weak var getReportButton: UIButton!
    @IBOutlet weak var tfBgView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var okImageView: UIImageView!
    @IBOutlet weak var secondTitle: UILabel!
    @IBOutlet weak var secondSubtitle: UILabel!
    
    private var viewState: ViewState = .getReport
    
    var presenter: HumanDesignPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setInitialViewConfigurations()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.barTintColor = UIColor.greyPurple
        self.presenter = HumanDesignPresenter.shared
    }
    
    private func setInitialViewConfigurations() {
        tfBgView.layer.cornerRadius = 25
        getReportButton.layer.cornerRadius = 25
        setViewElementsActive(state: .getReport)
    }
    
    private func setViewElementsActive(state: ViewState) {
        switch state {
        case .getReport:
            titleLabel.isHidden = false
            subtitleLabel.isHidden = false
            chartsImageView.isHidden = false
            tfBgView.isHidden = false
            secondTitle.isHidden = true
            secondSubtitle.isHidden = true
            okImageView.isHidden = true
            getReportButton.setTitle("Заказать расчет", for: .normal)
            
            return
        case .vaitReport:
            titleLabel.isHidden = true
            subtitleLabel.isHidden = true
            chartsImageView.isHidden = true
            tfBgView.isHidden = true
            secondTitle.isHidden = false
            secondSubtitle.isHidden = false
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
}
