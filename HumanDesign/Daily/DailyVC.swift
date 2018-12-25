//
//  DailyVC.swift
//  HumanDesign
//
//  Created by Pavlo Kharambura on 12/16/18.
//  Copyright © 2018 Pavlo Kharambura. All rights reserved.
//

import UIKit

class DailyVC: UIViewController {

    private enum CellIDS: String {
        case TextInfoTableViewCell = "TextInfoTableViewCell"
        case DailyImageTableViewCell = "DailyImageTableViewCell"
        case HelperViewTableViewCell = "HelperViewTableViewCell"
        case TypeViewTableViewCell = "TypeViewTableViewCell"
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: HumanDesignPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialConfigurations()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.barTintColor = UIColor.black
        self.presenter = HumanDesignPresenter.shared
        self.tableView.reloadData()
    }
    
    private func initialConfigurations() {
        configureTableView()
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = .clear
        self.tableView.register(UINib(nibName: CellIDS.HelperViewTableViewCell.rawValue, bundle: nil), forCellReuseIdentifier: CellIDS.HelperViewTableViewCell.rawValue)
        self.tableView.register(UINib(nibName: CellIDS.DailyImageTableViewCell.rawValue, bundle: nil), forCellReuseIdentifier: CellIDS.DailyImageTableViewCell.rawValue)
        self.tableView.register(UINib(nibName: CellIDS.TextInfoTableViewCell.rawValue, bundle: nil), forCellReuseIdentifier: CellIDS.TextInfoTableViewCell.rawValue)
        self.tableView.register(UINib(nibName: CellIDS.TypeViewTableViewCell.rawValue, bundle: nil), forCellReuseIdentifier: CellIDS.TypeViewTableViewCell.rawValue)

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
        return .lightContent
    }
    
}

extension DailyVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIDS.DailyImageTableViewCell.rawValue, for: indexPath) as? DailyImageTableViewCell else {return UITableViewCell()}
            
            
            cell.createGradientLayer()
            cell.shareButton.addTarget(self, action: #selector(shareAction), for: .touchUpInside)
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIDS.TypeViewTableViewCell.rawValue, for: indexPath) as? TypeViewTableViewCell else {return UITableViewCell()}
            
            cell.typeLabel.text = "Вы - \(presenter.getUser().info?.type ?? "")"
            
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIDS.TextInfoTableViewCell.rawValue, for: indexPath) as? TextInfoTableViewCell else {return UITableViewCell()}
            
            return cell
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIDS.HelperViewTableViewCell.rawValue, for: indexPath) as? HelperViewTableViewCell else {return UITableViewCell()}
            cell.bgImage.isHidden = true
            cell.headerLabel.text = "Не пропустите ежедневный прогноз!"
            cell.button.setTitle("Включить уведомления", for: .normal)
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return (self.view.frame.size.width)*(7/10)
        case 1:
            return 78
        case 3:
            return (self.view.frame.size.width)*0.75
        default:
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
}
