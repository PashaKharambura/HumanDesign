//
//  TypeInfoVC.swift
//  HumanDesign
//
//  Created by Pavlo Kharambura on 12/17/18.
//  Copyright © 2018 Pavlo Kharambura. All rights reserved.
//

import UIKit

class TypeInfoVC: UIViewController {

    
    private enum CellIDS: String {
        case TextInfoTableViewCell = "TextInfoTableViewCell"
        case DetailedTypeImageTableViewCell = "DetailedTypeImageTableViewCell"
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
        self.tableView.register(UINib(nibName: CellIDS.HelperViewTableViewCell.rawValue, bundle: nil), forCellReuseIdentifier: CellIDS.HelperViewTableViewCell.rawValue)
        self.tableView.register(UINib(nibName: CellIDS.DetailedTypeImageTableViewCell.rawValue, bundle: nil), forCellReuseIdentifier: CellIDS.DetailedTypeImageTableViewCell.rawValue)
        self.tableView.register(UINib(nibName: CellIDS.TextInfoTableViewCell.rawValue, bundle: nil), forCellReuseIdentifier: CellIDS.TextInfoTableViewCell.rawValue)

    }
    
    @objc
    private func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
    @objc
    private func shareAction() {
        let firstActivityItem = "Best Human Design App"
        let secondActivityItem = URL(string: "http://astroapi.ru/doc.html")!
        
        let activityViewController : UIActivityViewController = UIActivityViewController(
            activityItems: [firstActivityItem, secondActivityItem], applicationActivities: nil)
        
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
}

extension TypeInfoVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIDS.DetailedTypeImageTableViewCell.rawValue, for: indexPath) as? DetailedTypeImageTableViewCell else {return UITableViewCell()}
            
            cell.createGradientLayer()
            cell.backButton.addTarget(self, action: #selector(backAction), for: .touchUpInside)
            cell.shareButton.addTarget(self, action: #selector(shareAction), for: .touchUpInside)
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIDS.TextInfoTableViewCell.rawValue, for: indexPath) as? TextInfoTableViewCell else {return UITableViewCell()}

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
        case 0:
            return (self.view.frame.size.width)*(2/3)
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
