//
//  OnboardingSecondViewController.swift
//  CurrencyApp
//
//  Created by Humo Programmer on 10/12/20.
//

import UIKit

class OnboardingSecondViewController: UIViewController {
    
    //MARK: - Private variables
    
    private let data: [CurrencyItemModel] = [
        .init(image: UIImage(named: "rub"), code: "RUB", name: "Российский Рубль"),
        .init(image: UIImage(named: "usd"), code: "USD", name: "Доллар США"),
        .init(image: UIImage(named: "eur"), code: "EUR", name: "Евро")]
    
    //MARK: - GUI variables
    
    private lazy var stepLabel: UILabel = {
        var label = UILabel()
        label.text = "шаг 2 из 3"
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var titleLabel: UILabel = {
        var label = UILabel()
        label.text = "Выберите валюту"
        label.textColor = UIColor.black.withAlphaComponent(0.87)
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var currencyView: DefaultCurrencyView = {
        var view = DefaultCurrencyView()
        view.initView(data: self.data)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var descriptionLabel: UILabel = {
        var label = UILabel()
        label.text = "Вы можете потом поменять это в настройках"
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor.black.withAlphaComponent(0.60)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var continueButton: UIButton = {
        var button = UIButton(type: .system)
        button.layer.cornerRadius = 8
        button.backgroundColor = .init(rgb: 0x219653)
        button.setTitle("Далее", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .medium)
        button.addTarget(self, action: #selector(self.continueButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        self.addSubviews()
        self.makeConstraints()
    }
    
    //MARK: - Constraints
    
    private func makeConstraints() {
        self.stepLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.topLayoutGuide.snp.bottom).offset(24)
            make.left.right.equalToSuperview().inset(24)
        }
        self.titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.stepLabel.snp.bottom).offset(8)
            make.left.right.equalToSuperview().inset(24)
        }
        self.currencyView.snp.makeConstraints { (make) in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(24)
            make.left.right.equalToSuperview().inset(24)
        }
        self.continueButton.snp.makeConstraints { (make) in
            make.top.greaterThanOrEqualTo(self.currencyView.snp.bottom).offset(24)
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(48)
        }
        self.descriptionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.continueButton.snp.bottom).offset(10)
            make.left.right.bottom.equalToSuperview().inset(32)
        }
    }
    
    //MARK: - Setters
    
    private func addSubviews() {
        self.view.addSubview(self.stepLabel)
        self.view.addSubview(self.titleLabel)
        self.view.addSubview(self.currencyView)
        self.view.addSubview(self.continueButton)
        self.view.addSubview(self.descriptionLabel)
    }
    
    //MARK: - Actions
    
    @objc private func continueButtonTapped() {
        if let parent = self.parent as? OnboardingPageViewController {
            parent.setViewControllers([parent.pages[2]], direction: .forward, animated: true, completion: nil)
        }
    }
    
}
