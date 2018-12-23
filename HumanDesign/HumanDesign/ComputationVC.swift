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
    
    @IBOutlet weak var viewOfPicker: UIView! {didSet{viewOfPicker.alpha = 0}}
    @IBOutlet weak var pickerView: UIPickerView! {didSet{pickerView.layer.cornerRadius = 25}}
    @IBOutlet weak var doneButton: UIButton! {didSet{doneButton.layer.cornerRadius = 25}}
    
    var presenter = HumanDesignPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialViewConfigurations()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.barTintColor = UIColor.greyPurple
    }

    private func initialViewConfigurations() {
        configureBgViews()
        configurePicker()
    }
    
    private func configurePicker() {
        pickerView.delegate = self
        pickerView.dataSource = self
        
    }
    
    private func configureBgViews() {
        let views = [view1,view2,view3,view4,view5,view6,countButton]
        for view in views {
            view?.layer.cornerRadius = 25
        }
    }
    
    @IBAction func ButtonAction(_ sender: Any) {
        presenter.getGraphInfo(success: {
            self.performSegue(withIdentifier: "HumanDesignSegue", sender: nil)
        }, failure: { (error) in
            self.showSimpleAlert(title: "Ошибка", text: "Проверьте введенные данные")
        }) {
            self.showSimpleAlert(title: "Проверьте соединение", text: "")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "HumanDesignSegue":
            guard let vc = segue.destination as? HumanDesignVC else {return}
            vc.presenter = self.presenter
        default:
            return
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func setDay(_ sender: Any) {
        presenter.setPickerType(type: .Day)
        openPicker()
    }
    @IBAction func setMonth_(_ sender: Any) {
        presenter.setPickerType(type: .Month)
        openPicker()
    }
    @IBAction func setYear_(_ sender: Any) {
        presenter.setPickerType(type: .Year)
        openPicker()
    }
    @IBAction func setCountry(_ sender: Any) {
        presenter.setPickerType(type: .Country)
        openPicker()
    }
    @IBAction func setCity(_ sender: Any) {
        presenter.setPickerType(type: .City)
        openPicker()
    }
    @IBAction func setTime(_ sender: Any) {
        presenter.setPickerType(type: .Time)
        openPicker()
    }
    @IBAction func setApproximately(_ sender: Any) {
        presenter.setPickerType(type: .Approximately)
        openPicker()
    }
    @IBAction func doneAction(_ sender: Any) {
        closePicker()
    }
    
}

extension ComputationVC: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return presenter.getCountForPicker()
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return presenter.getDataForPicker()[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        presenter.setDataFromPicker(index: row)
        switch presenter.getPickerType() {
        case .Day:
            dayLabel.text = "\(presenter.dataSource.getUser().birthDay)"
        case .Country:
            countryLabel.text = "\(presenter.dataSource.getUser().country)"
        case .City:
            cityLabel.text = "\(presenter.dataSource.getUser().city)"
        case .Month:
            let index = presenter.dataSource.getUser().birthMonth
            month.text = "\(presenter.dataSource.getMonths()[index])"
        case .Year:
            yearLabel.text = "\(presenter.dataSource.getUser().birthYear)"
        case .Approximately:
            timeLabel.text = "\(presenter.dataSource.getUser().birthHour):\(presenter.dataSource.getUser().birthMinute)"
        case .Time:
            timeLabel.text = "\(presenter.dataSource.getUser().birthHour):\(presenter.dataSource.getUser().birthMinute)"

        }
    }
    
    func openPicker() {
        pickerView.reloadAllComponents()
        viewOfPicker.alpha = 1
    }
    
    func closePicker() {
        viewOfPicker.alpha = 0
    }
    
}
