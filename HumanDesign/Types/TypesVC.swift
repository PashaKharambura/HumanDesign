//
//  TypesVC.swift
//  HumanDesign
//
//  Created by Pavlo Kharambura on 12/16/18.
//  Copyright © 2018 Pavlo Kharambura. All rights reserved.
//

import UIKit

class TypesVC: UIViewController, UIGestureRecognizerDelegate {

    private enum CellIDS: String {
        case TypesHeaderTextInfoTableViewCell = "TypesHeaderTextInfoTableViewCell"
        case TypesCollectionTableViewCell = "TypesCollectionTableViewCell"
        case HelperViewTableViewCell = "HelperViewTableViewCell"
    }
    
    @IBOutlet weak var tableView: UITableView!
    var presenter: HumanDesignPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialConfigurations()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.barTintColor = UIColor.black
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        presenter = HumanDesignPresenter.shared
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    private func initialConfigurations() {
        configureTableView()
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = .clear
        self.tableView.register(UINib(nibName: CellIDS.TypesHeaderTextInfoTableViewCell.rawValue, bundle: nil), forCellReuseIdentifier: CellIDS.TypesHeaderTextInfoTableViewCell.rawValue)
        self.tableView.register(UINib(nibName: CellIDS.TypesCollectionTableViewCell.rawValue, bundle: nil), forCellReuseIdentifier: CellIDS.TypesCollectionTableViewCell.rawValue)
        self.tableView.register(UINib(nibName: CellIDS.HelperViewTableViewCell.rawValue, bundle: nil), forCellReuseIdentifier: CellIDS.HelperViewTableViewCell.rawValue)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "ShowTypeInfoSegue":
            guard let vc = segue.destination as? TypeInfoVC else {return}
            
            return
        default:
            
            return
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    @objc
    private func fillPersonalMap(_ sender: UIButton) {
        self.tabBarController?.selectedIndex = 1
    }
    
}

extension TypesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIDS.TypesHeaderTextInfoTableViewCell.rawValue, for: indexPath) as? TypesHeaderTextInfoTableViewCell else {return UITableViewCell()}
            cell.TitleLabel.text = NSLocalizedString("Типы личностей", comment: "")
            cell.lastCalculationLabel.text = "\(NSLocalizedString("Последний расчет", comment: "")): \(UserProfileTypeManager.getType(by: presenter.getUser().info?.type ?? "")?.name ?? "\(NSLocalizedString("Проведите расчет", comment: ""))")"
            cell.additionalInfoLabel.text = NSLocalizedString("Тип является одним из ключевых понятий дизайна человека. Каждый генетический тип имеет свою уникальную стратегию в жизни.", comment: "")
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIDS.TypesCollectionTableViewCell.rawValue, for: indexPath) as? TypesCollectionTableViewCell else {return UITableViewCell()}
            
            cell.delegate = self
            cell.state = .type
            
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIDS.TypesHeaderTextInfoTableViewCell.rawValue, for: indexPath) as? TypesHeaderTextInfoTableViewCell else {return UITableViewCell()}
            cell.TitleLabel.text = NSLocalizedString("Профили", comment: "")
            cell.lastCalculationLabel.text = "\(NSLocalizedString("Последний расчет", comment: "")): \(UserProfileTypeManager.getProfile(by: presenter.getUser().info?.profile ?? "")?.name ?? "\(NSLocalizedString("Проведите расчет", comment: ""))")"
            cell.additionalInfoLabel.text = NSLocalizedString("Это «костюм», или роль, которую вы играете на сцене жизни, когда проживаете то, что вам предназначено. Это — определение.", comment: "")
            return cell
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIDS.TypesCollectionTableViewCell.rawValue, for: indexPath) as? TypesCollectionTableViewCell else {return UITableViewCell()}
            
            cell.delegate = self
            cell.state = .profile
            
            return cell
        case 4:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIDS.HelperViewTableViewCell.rawValue, for: indexPath) as? HelperViewTableViewCell else {return UITableViewCell()}
            
            cell.button.addTarget(self, action: #selector(fillPersonalMap(_:)), for: .touchUpInside)
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 1:
            return (self.view.frame.size.width/2)*3.75
        case 3:
            return (self.view.frame.size.width/2)*7.5
        case 4:
            return (self.view.frame.size.width)*0.75
        default:
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
}

extension TypesVC: TypesCollectionViewDelegate {
  
    func selectType(index: Int) {
        self.performSegue(withIdentifier: "ShowTypeInfoSegue", sender: index)
    }
    
}
