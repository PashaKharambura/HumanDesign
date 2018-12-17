//
//  TypesVC.swift
//  HumanDesign
//
//  Created by Pavlo Kharambura on 12/16/18.
//  Copyright © 2018 Pavlo Kharambura. All rights reserved.
//

import UIKit

class TypesVC: UIViewController {

    private enum CellIDS: String {
        case TypesHeaderTextInfoTableViewCell = "TypesHeaderTextInfoTableViewCell"
        case TypesCollectionTableViewCell = "TypesCollectionTableViewCell"
        case HelperViewTableViewCell = "HelperViewTableViewCell"
    }
    
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
        self.tableView.register(UINib(nibName: CellIDS.TypesCollectionTableViewCell.rawValue, bundle: nil), forCellReuseIdentifier: CellIDS.TypesCollectionTableViewCell.rawValue)
        self.tableView.register(UINib(nibName: CellIDS.HelperViewTableViewCell.rawValue, bundle: nil), forCellReuseIdentifier: CellIDS.HelperViewTableViewCell.rawValue)

    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}

extension TypesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIDS.TypesHeaderTextInfoTableViewCell.rawValue, for: indexPath) as? TypesHeaderTextInfoTableViewCell else {return UITableViewCell()}
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIDS.TypesCollectionTableViewCell.rawValue, for: indexPath) as? TypesCollectionTableViewCell else {return UITableViewCell()}
            
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIDS.HelperViewTableViewCell.rawValue, for: indexPath) as? HelperViewTableViewCell else {return UITableViewCell()}
            
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 1:
            return (self.view.frame.size.width/2)*2.5
        case 2:
            return (self.view.frame.size.width)*0.75
        
        default:
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
}
