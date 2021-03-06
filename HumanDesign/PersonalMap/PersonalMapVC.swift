
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
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
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
            let applyForComput = NSLocalizedString("Заказать расчет", comment: "")
            getReportButton.setTitle(applyForComput, for: .normal)
            
            return
        case .vaitReport:
            titleLabel.isHidden = true
            subtitleLabel.isHidden = true
            chartsImageView.isHidden = true
            tfBgView.isHidden = true
            secondTitle.isHidden = false
            secondSubtitle.isHidden = false
            okImageView.isHidden = false
            let compGraph = NSLocalizedString("Рассчитать бодиграф", comment: "")
            getReportButton.setTitle(compGraph, for: .normal)
            
            return
        }
    }

    @IBAction func buttonAtion(_ sender: Any) {
        if viewState == .vaitReport {
            self.tabBarController?.selectedIndex = 0
        } else if viewState == .getReport {
            if let email = emailTextField.text {
                if isValidEmail(testStr: email) {
                    presenter.sendEmailTo(type: .PersonalMap ,email: email, success: {
                        self.viewState = .vaitReport
                        self.setViewElementsActive(state: self.viewState)
                    }) { (error) in
                        self.showSimpleAlert(title: errorTitle, text: error.localizedDescription)
                    }
                } else {
                    showSimpleAlert(title: errorTitle, text: NSLocalizedString("Введите корректную почту!", comment: ""))
                }
            } else {
                showSimpleAlert(title: errorTitle, text: NSLocalizedString("Введите почту!", comment: ""))
            }
        }

    }
}
