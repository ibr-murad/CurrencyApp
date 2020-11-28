//
//  SettingsViewController.swift
//  CurrencyApp
//
//  Created by Humo Programmer on 10/12/20.
//

import UIKit

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
              titles: ["Написать в Telegram",
                       "Написать в WhatsApp",
                       "Написать в Viber"])]
    
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
    
    private lazy var notificationsSwitch: UISwitch = {
        var switchh = UISwitch()
        switchh.addTarget(
            self, action: #selector(self.notificationSwithValueChange),
            for: .valueChanged)
        switchh.translatesAutoresizingMaskIntoConstraints = false
        return switchh
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
    
    @objc private func notificationSwithValueChange(_ sender: UISwitch) {
        print(sender.isOn)
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
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let modeVC =  CurrencyModeViewController()
                Interface.shared.pushVC(vc: modeVC)
            } else if indexPath.row == 1 {
                let currencyVC =  DefaultCurrencyViewController()
                Interface.shared.pushVC(vc: currencyVC)
            } else if indexPath.row == 2 {
                self.notificationsSwitch.setOn(!self.notificationsSwitch.isOn, animated: true)
                self.notificationSwithValueChange(self.notificationsSwitch)
            } else if indexPath.row == 3 {
                print("call in app review")
            }
            
        } else if indexPath.section == 1 {
            if indexPath.row == 0 {
                //link to telegram
            } else if indexPath.row == 1 {
                //link to whatsapp
            } else if indexPath.row == 2 {
                //link to viber
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
            cell.accessoryType = .none
            cell.accessoryView = self.notificationsSwitch
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
        } else if indexPath.row == 1 {
            cell.textLabel?.textColor = .init(rgb: 0x128C7E)
        } else if indexPath.row == 2 {
            cell.textLabel?.textColor = .purple
        }
        return cell
    }
    
}
