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
    
    var presenter: HumanDesignPresenter!
    private var viewState: ViewState = .getReport
    
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
        if viewState == .vaitReport {
            self.tabBarController?.selectedIndex = 0
        } else if viewState == .getReport {
            if let email = emailTextField.text {
                if isValidEmail(testStr: email) {
                    presenter.sendEmailTo(type: .FindLove ,email: email, success: {
                        self.viewState = .vaitReport
                        self.setViewElementsActive(state: self.viewState)
                    }) { (error) in
                        self.showSimpleAlert(title: "Error", text: error.localizedDescription)
                    }
                } else {
                    showSimpleAlert(title: "Ошибка", text: "Введите корректную почту!")
                }
            } else {
                showSimpleAlert(title: "Ошибка", text: "Введите почту!")
            }
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}
