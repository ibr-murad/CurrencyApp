//
//  SettingsViewController.swift
//  CurrencyApp
//
//  Created by Humo Programmer  on 10/12/20.
//

import UIKit

class SettingsViewController: BaseViewController {
    
    //MARK: - Public variables
    
    //MARK: - Private variables
    
    private let tableViewCellReuseIdentifier = "SettingsTableViewCell"
    
    private let data: [SettingsTableViewSectionModel] = [
        .init(header: "ОБЩИЕ", titles: ["Опция показа курсов валют", "Валюта по умолчанию", "Title 1", "Уведомления"]),
        .init(header: "ПОДДЕРЖКА", titles: ["Написать в Telegram"])]
    
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
        self.setupNavigationBar()
        self.addSubviews()
        self.makeConstraints()
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
    
    private func setupNavigationBar() {
        self.navigationItem.title = "Настройки"
        if #available(iOS 11.0, *) {
            self.navigationItem.largeTitleDisplayMode = .never
        }
    }
    
    @objc private func notificationSwithValueChange(_ sender: UISwitch) {
        UserDefaults.standard.set(sender.isOn, forKey: "isPlainMode")
        NotificationCenter.default.post(name: .modeUpdated, object: nil)
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
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            
            var random = Int.random(in: 0...2)
            switch random {
            case 0:
                Settings.shared.currentCurrencyName = "RUB"
                break
            case 1:
                Settings.shared.currentCurrencyName = "USD"
                break
            case 2:
                Settings.shared.currentCurrencyName = "EUR"
                break
            default:
                break
            }
            print("currency changed to \(Settings.shared.currentCurrencyName)")
        }
    }
    
    func cellForFirstSection(cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: self.tableViewCellReuseIdentifier)
        let titles = self.data[indexPath.section].titles
        cell.textLabel?.text = titles[indexPath.row]
        if !(indexPath.row == titles.count - 1) {
            cell.detailTextLabel?.text = "Detail"
            cell.detailTextLabel?.textColor = .init(rgb: 0x3C3C43, alpha: 0.3)
            cell.accessoryType = .disclosureIndicator
        } else {
            cell.accessoryType = .none
            cell.accessoryView = self.notificationsSwitch
        }
        cell.tintColor = .init(rgb: 0x3C3C43, alpha: 0.3)
        return cell
    }
    
    func cellForSecondSection(cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: self.tableViewCellReuseIdentifier)
        let titles = self.data[indexPath.section].titles
        cell.textLabel?.text = titles[indexPath.row]
        cell.textLabel?.textColor = .init(rgb: 0x007AFF)
        return cell
    }
}
 
