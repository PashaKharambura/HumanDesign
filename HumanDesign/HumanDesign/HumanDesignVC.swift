//
//  HumanDesignVC.swift
//  HumanDesign
//
//  Created by Pavlo Kharambura on 12/17/18.
//  Copyright © 2018 Pavlo Kharambura. All rights reserved.
//

import UIKit

class HumanDesignVC: UIViewController {

    private enum CellIDS: String {
        case TypesHeaderTextInfoTableViewCell = "TypesHeaderTextInfoTableViewCell"
        case HumanDesingTableViewCell = "HumanDesingTableViewCell"
        case TextInfoTableViewCell = "TextInfoTableViewCell"
        case TripleSpecificationTableViewCell = "TripleSpecificationTableViewCell"
        case HelperViewTableViewCell = "HelperViewTableViewCell"
        case TitleTableViewCell = "TitleTableViewCell"
        case TypesCollectionTableViewCell = "TypesCollectionTableViewCell"
        case WhiteButtonTableViewCell = "WhiteButtonTableViewCell"
    }
    
    @IBOutlet weak var yourGraphTitle: UILabel!
    
    var presenter: HumanDesignPresenter?
    var image: UIImage?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialConfigurations()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.barTintColor = UIColor.black
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private func initialConfigurations() {
        configureTableView()
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = .clear
        self.tableView.register(UINib(nibName: CellIDS.TypesHeaderTextInfoTableViewCell.rawValue, bundle: nil), forCellReuseIdentifier: CellIDS.TypesHeaderTextInfoTableViewCell.rawValue)
        self.tableView.register(UINib(nibName: CellIDS.HumanDesingTableViewCell.rawValue, bundle: nil), forCellReuseIdentifier: CellIDS.HumanDesingTableViewCell.rawValue)
        self.tableView.register(UINib(nibName: CellIDS.TextInfoTableViewCell.rawValue, bundle: nil), forCellReuseIdentifier: CellIDS.TextInfoTableViewCell.rawValue)
        self.tableView.register(UINib(nibName: CellIDS.TripleSpecificationTableViewCell.rawValue, bundle: nil), forCellReuseIdentifier: CellIDS.TripleSpecificationTableViewCell.rawValue)
        self.tableView.register(UINib(nibName: CellIDS.HelperViewTableViewCell.rawValue, bundle: nil), forCellReuseIdentifier: CellIDS.HelperViewTableViewCell.rawValue)
        self.tableView.register(UINib(nibName: CellIDS.TitleTableViewCell.rawValue, bundle: nil), forCellReuseIdentifier: CellIDS.TitleTableViewCell.rawValue)
        self.tableView.register(UINib(nibName: CellIDS.TypesCollectionTableViewCell.rawValue, bundle: nil), forCellReuseIdentifier: CellIDS.TypesCollectionTableViewCell.rawValue)
        self.tableView.register(UINib(nibName: CellIDS.WhiteButtonTableViewCell.rawValue, bundle: nil), forCellReuseIdentifier: CellIDS.WhiteButtonTableViewCell.rawValue)
    }

    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func shareAction(_ sender: Any) {
        let type = UserProfileTypeManager.getType(by: presenter?.getUser().info?.type ?? "")
        let firstActivityItem = "Я - \(type?.name ?? ""), профайл - \(presenter?.getUser().info?.profile ?? "") \nУзнай свой дизайн с помощью приложения - {URL будет позже} "
        var items: [Any] = [firstActivityItem]
        if let image = self.image {
            items.insert(image, at: 0)
        }
        let activityViewController : UIActivityViewController = UIActivityViewController(
            activityItems: items, applicationActivities: nil)
        
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    @objc
    private func showAllTypes() {
        self.tabBarController?.selectedIndex = 2
    }
    @objc
    private func selectProfile() {
        UserProfileTypeManager.state = .profile
        UserProfileTypeManager.selectedProfile = UserProfileTypeManager.getProfile(by: presenter?.getUser().info?.profile ?? "")

        self.performSegue(withIdentifier: "showMyTypeInfoSegue", sender: nil)
    }
    @objc
    private func selectUserType() {
        UserProfileTypeManager.state = .type
        UserProfileTypeManager.selectedType = UserProfileTypeManager.getType(by: presenter?.getUser().info?.type ?? "")
        
        self.performSegue(withIdentifier: "showMyTypeInfoSegue", sender: nil)
    }
    
    
}

extension HumanDesignVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIDS.TypesHeaderTextInfoTableViewCell.rawValue, for: indexPath) as? TypesHeaderTextInfoTableViewCell else {return UITableViewCell()}
            
            let yourBodyGraph = NSLocalizedString("Ваш бодиграф", comment: "")
            cell.TitleLabel.text = yourBodyGraph
            if let info = presenter?.getUser().info {
                cell.TitleLabel.text = UserProfileTypeManager.getType(by: info.type)?.name
            }
            let bInfo = "\(String(format: "%02d",presenter?.getUser().birthDay ?? 0)).\(String(format: "%02d",presenter?.getUser().birthMonth ?? 0)).\(String(format: "%04d",presenter?.getUser().birthYear ?? 0)), \(String(format: "%02d",presenter?.getUser().birthHour ?? 0)):\(String(format: "%02d", presenter?.getUser().birthMinute ?? 0)), \(presenter?.getUser().city ?? "")"
            cell.lastCalculationLabel.text = bInfo
            
            
            cell.additionalInfoLabel.isHidden = true
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIDS.HumanDesingTableViewCell.rawValue, for: indexPath) as? HumanDesingTableViewCell else {return UITableViewCell()}
            
            if let userInfo = presenter?.dataSource.getUser().info {
                let red = userInfo.designGates
                let blue = userInfo.personalGates

                cell.delegate = self
                cell.activeRedNumbers = red
                cell.activeBlueNumbers = blue
                var blueNumbers = [ActiveBodyGraphNumber]()
                var redNumbers = [ActiveBodyGraphNumber]()
                for i in red {
                    redNumbers.append(ActiveBodyGraphNumber(number: Int(i), withColor: .red))
                }
                for i in blue {
                    blueNumbers.append(ActiveBodyGraphNumber(number: Int(i), withColor: .blue))
                }
                cell.activeNumbers = redNumbers+blueNumbers
                cell.superActiveNumbers = userInfo.superActiveNumbers
            }

            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIDS.TextInfoTableViewCell.rawValue, for: indexPath) as? TextInfoTableViewCell else {return UITableViewCell()}
            
            if let info = presenter?.getUser().info {
                cell.textInfoLabel.text = (UserProfileTypeManager.getType(by: info.type)?.info ?? "") + "\n\n\n" + (UserProfileTypeManager.getProfile(by: info.profile)?.info ?? "")
            }
            
            return cell
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIDS.TripleSpecificationTableViewCell.rawValue, for: indexPath) as? TripleSpecificationTableViewCell else {return UITableViewCell()}
            if let info = presenter?.getUser().info {
                cell.yourTypeLabel.text = UserProfileTypeManager.getType(by: info.type)?.name
                cell.yourProfileLabel.text = UserProfileTypeManager.getProfile(by: presenter?.getUser().info?.profile ?? "")?.name
                cell.yourDefinitionLabel.text = UserProfileTypeManager.getDefinition(int: presenter?.getUser().info?.definition ?? 0)
                
//                cell.selectTypeButton.addTarget(self, action: #selector(selectUserType), for: .touchUpInside)
//                cell.selectProvileButton.addTarget(self, action: #selector(selectProfile), for: .touchUpInside)
            }
            return cell
        case 4:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIDS.HelperViewTableViewCell.rawValue, for: indexPath) as? HelperViewTableViewCell else {return UITableViewCell()}
            
            return cell
        case 5:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIDS.TitleTableViewCell.rawValue, for: indexPath) as? TitleTableViewCell else {return UITableViewCell()}
            cell.titleLabel.text = NSLocalizedString("Типы личности", comment: "")
            return cell
        case 6:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIDS.TypesCollectionTableViewCell.rawValue, for: indexPath) as? TypesCollectionTableViewCell else {return UITableViewCell()}
    
            cell.delegate = self
            cell.state = .type
            cell.collectionView.isScrollEnabled = false
            return cell
        case 7:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIDS.WhiteButtonTableViewCell.rawValue, for: indexPath) as? WhiteButtonTableViewCell else {return UITableViewCell()}
           
            cell.button.addTarget(self, action: #selector(showAllTypes), for: .touchUpInside)
            
            return cell
        default:
            return UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 100
        case 1:
            return (self.view.frame.size.width)*(1.25)
        case 3:
            return 230
        case 4:
            return (self.view.frame.size.width)*(0.75)
        case 5:
            return 75
        case 6:
            return (self.view.frame.size.width/2)*(2.5)
        case 7:
            return 100
        default:
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        switch indexPath.row {
        case 1:
            return nil
        default:
            return indexPath
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 1:
            guard let graphCell = cell as? HumanDesingTableViewCell else { return }
            graphCell.layoutIfNeeded()
        default:
            return
        }
    }
    
}

extension HumanDesignVC: BodyGraphProtocol {
    func getImage(image: UIImage) {
        self.image = image
    }
}

extension HumanDesignVC: TypesCollectionViewDelegate {

    func selectType(index: Int) {
        self.performSegue(withIdentifier: "showMyTypeInfoSegue", sender: nil)
    }

}
