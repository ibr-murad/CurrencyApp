//
//  SettingsViewController.swift
//  CurrencyApp
//
//  Created by Murodjon Ibrohimovon 10/12/20.
//

import UIKit
import StoreKit

class SettingsViewController: BaseViewController {
    
    //MARK: - Private variables
    
    private let tableViewCellReuseIdentifier = "SettingsTableViewCell"
    private let data: [SettingsTableViewSectionModel] = [
        .init(header: "ОБЩИЕ",
              titles: ["Опция показа курсов валют",
                       "Валюта по умолчанию",
                       "Уведомления",
                       "Оцените приложение"]),
        .init(header: "ПОДДЕРЖКА",
              titles: ["Написать в Telegram"])]
    
    //MARK: - GUI variables
    
    private lazy var tableView: UITableView = {
        var tableView = UITableView(frame: .zero, style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .groupTableViewBackground
        tableView.separatorStyle = .singleLine
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
        tableView.showsVerticalScrollIndicator = false
        tableView.tableHeaderView?.backgroundColor = .clear
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: self.tableViewCellReuseIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    //MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.navigationItem.title = "Настройки"
        self.addSubviews()
        self.makeConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if #available(iOS 11.0, *) {
            navigationItem.largeTitleDisplayMode = .never
        }
        self.tableView.reloadData()
    }
    
    //MARK: - Constraints
    
    private func makeConstraints() {
        self.tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    //MARK: - Setters
    
    private func addSubviews() {
        self.view.addSubview(self.tableView)
    }
    
}

//MARK: - UITableViewDelegate, UITableViewDataSource

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.data[section].header
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data[section].titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = indexPath.section == 0 ?
            self.cellForFirstSection(cellForRowAt: indexPath) :
            self.cellForSecondSection(cellForRowAt: indexPath)
        let selectedBackgroungView = UIView()
        selectedBackgroungView.backgroundColor = UIColor(red: 251.0 / 255.0, green: 251.0 / 255.0, blue: 251.0 / 255.0, alpha: 1.0)
        cell.selectedBackgroundView = selectedBackgroungView
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let modeVC =  CurrencyModeViewController()
                Interface.shared.pushVC(vc: modeVC)
            } else if indexPath.row == 1 {
                let currencyVC =  DefaultCurrencyViewController()
                Interface.shared.pushVC(vc: currencyVC)
            } else if indexPath.row == 2 {
                if let appSettings = NSURL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(appSettings as URL)
                }
            } else if indexPath.row == 3 {
                if #available(iOS 10.3, *) {
                    SKStoreReviewController.requestReview()
                }
            }
            
        } else if indexPath.section == 1 {
            if indexPath.row == 0 {
                let botURL = URL.init(string: "tg://resolve?domain=rublerusd")

                if UIApplication.shared.canOpenURL(botURL!) {
                    UIApplication.shared.open(botURL!)
                }

            }
        }
    }
    
    func cellForFirstSection(cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: self.tableViewCellReuseIdentifier)
        let titles = self.data[indexPath.section].titles
        cell.textLabel?.text = titles[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        cell.detailTextLabel?.textColor = .init(rgb: 0x3C3C43, alpha: 0.3)
        cell.tintColor = .init(rgb: 0x3C3C43, alpha: 0.3)
        if indexPath.row == 0 {
            cell.detailTextLabel?.text = Settings.shared.mode.rawValue
        } else if indexPath.row == 1 {
            cell.detailTextLabel?.text = Settings.shared.defaultCurrency.rawValue
        } else if indexPath.row == 2 {
            cell.accessoryType = .disclosureIndicator
        } else if indexPath.row == 3 {
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    func cellForSecondSection(cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: self.tableViewCellReuseIdentifier)
        let titles = self.data[indexPath.section].titles
        cell.textLabel?.text = titles[indexPath.row]
        if indexPath.row == 0 {
            cell.textLabel?.textColor = .init(rgb: 0x007AFF)
            cell.imageView?.image = UIImage(named: "telegram")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        0
    }
    
}
