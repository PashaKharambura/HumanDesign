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
    
    var presenter: HumanDesignPresenter?

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialConfigurations()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.barTintColor = UIColor.black
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
        let firstActivityItem = "Best Human Design App"
        let secondActivityItem = URL(string: "http://astroapi.ru/doc.html")!
        
        let activityViewController : UIActivityViewController = UIActivityViewController(
            activityItems: [firstActivityItem, secondActivityItem], applicationActivities: nil)
        
        self.present(activityViewController, animated: true, completion: nil)
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
            cell.TitleLabel.text = "Вы – Динамо-машина"
            cell.lastCalculationLabel.text = "01.12.1980, 17:38, г. Санкт-Петербург"
            cell.additionalInfoLabel.isHidden = true
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIDS.HumanDesingTableViewCell.rawValue, for: indexPath) as? HumanDesingTableViewCell else {return UITableViewCell()}
            cell.layoutIfNeeded()
            
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIDS.TextInfoTableViewCell.rawValue, for: indexPath) as? TextInfoTableViewCell else {return UITableViewCell()}
            cell.textInfoLabel.text = "Настоящая динамо-машина с самым большим энергетическим потенциалом среди всех типов. Человек-аномалия, пятый элемент. Вы не умеете ждать, любую ситуацию вы готовы брать в свои руки и быть уверенным на все 100, что результат будет ошеломляющим. Но часто жизнь преподносит вам уроки, которые необходимо учитывать."
            return cell
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIDS.TripleSpecificationTableViewCell.rawValue, for: indexPath) as? TripleSpecificationTableViewCell else {return UITableViewCell()}
            
            return cell
        case 4:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIDS.HelperViewTableViewCell.rawValue, for: indexPath) as? HelperViewTableViewCell else {return UITableViewCell()}
            
            return cell
        case 5:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIDS.TitleTableViewCell.rawValue, for: indexPath) as? TitleTableViewCell else {return UITableViewCell()}
            
            return cell
        case 6:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIDS.TypesCollectionTableViewCell.rawValue, for: indexPath) as? TypesCollectionTableViewCell else {return UITableViewCell()}
            cell.delegate = self
            return cell
        case 7:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIDS.WhiteButtonTableViewCell.rawValue, for: indexPath) as? WhiteButtonTableViewCell else {return UITableViewCell()}
            
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
//            graphCell.layoutIfNeeded()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                graphCell.lineView.setNeedsDisplay()
            }
        default:
            return
        }
    }
    
}


extension HumanDesignVC: TypesCollectionViewDelegate {

    func selectType(index: Int) {
        self.performSegue(withIdentifier: "showMyTypeInfoSegue", sender: nil)
    }

}
