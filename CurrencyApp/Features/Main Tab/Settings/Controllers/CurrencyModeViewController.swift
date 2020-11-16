//
//  CurrencyModeViewController.swift
//  CurrencyApp
//
//  Created by Humo Programmer  on 11/3/20.
//

import UIKit

class CurrencyModeViewController: UIViewController {
    
    //MARK: - Public variables
    
    var selectedMode: Settings.Mode?
    
    //MARK: - GUI variables
    
    private lazy var currencyModeView: CurrencyModeView = {
        var view = CurrencyModeView()
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
        self.navigationItem.title = "Режим"
        
        self.addSubviews()
        self.makeConstraints()
    }
    
    //MARK: - Constraints
    
    private func makeConstraints() {
        self.currencyModeView.snp.makeConstraints { (make) in
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
        self.view.addSubview(self.currencyModeView)
        self.view.addSubview(self.saveButton)
    }
    
    //MARK: - Actions
    
    @objc private func saveButtonTapped(_ sender: UIButton) {
        Interface.shared.popVC()
        if let mode = self.currencyModeView.selectedMode {
            Settings.shared.mode = mode
            NotificationCenter.default.post(name: .modeUpdated, object: nil)
        }
    }
    
}
