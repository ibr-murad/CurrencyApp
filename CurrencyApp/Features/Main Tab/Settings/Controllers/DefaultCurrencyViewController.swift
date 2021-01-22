//
//  DefaultCurrencyViewController.swift
//  CurrencyApp
//
//  Created by Murodjon Ibrohimovon 11/3/20.
//

import UIKit

class DefaultCurrencyViewController: UIViewController {
    
    //MARK: - Private variables
    
    private let data: [CurrencyItemModel] = [
        .init(image: UIImage(named: "rub"), code: "RUB", name: "Российский Рубль"),
        .init(image: UIImage(named: "usd"), code: "USD", name: "Доллар США"),
        .init(image: UIImage(named: "eur"), code: "EUR", name: "Евро")]
    
    //MARK: - GUI variables
    
    private lazy var currencyView: DefaultCurrencyView = {
        var view = DefaultCurrencyView()
        view.initView(data: self.data)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var saveButton: UIButton = {
        var button = UIButton(type: .system)
        button.layer.cornerRadius = 16
        button.backgroundColor = .init(rgb: 0x219653)
        button.setTitle("Сохранить", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .medium)
        button.addTarget(self, action: #selector(self.saveButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.navigationItem.title = "Валюта по умолчанию"
        
        self.addSubviews()
        self.makeConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if #available(iOS 11.0, *) {
            navigationItem.largeTitleDisplayMode = .never
        }
    }
    
    //MARK: - Constraints
    
    private func makeConstraints() {
        self.currencyView.snp.makeConstraints { (make) in
            make.top.equalTo(self.topLayoutGuide.snp.bottom).offset(40)
            make.left.right.equalToSuperview().inset(24)
        }
        self.saveButton.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(24)
            make.bottom.equalTo(self.bottomLayoutGuide.snp.top).offset(-40)
            make.height.equalTo(48)
        }
    }
    
    //MARK: - Setters
    
    private func addSubviews() {
        self.view.addSubview(self.currencyView)
        self.view.addSubview(self.saveButton)
    }
    
    //MARK: - Actions
    
    @objc private func saveButtonTapped() {
        Interface.shared.popVC()
        if let currency = self.currencyView.selectedCurrency {
            Settings.shared.defaultCurrency = currency
            NotificationCenter.default.post(name: .defaultCurrencyUpdated, object: nil)
        }
    }
    
}
