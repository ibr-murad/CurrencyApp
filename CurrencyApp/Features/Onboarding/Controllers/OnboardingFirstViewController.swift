//
//  OnboardingFirstViewController.swift
//  CurrencyApp
//
//  Created by Humo Programmer  on 10/12/20.
//

import UIKit

class OnboardingFirstViewController: UIViewController {
    
    //MARK: - Public variables
    
    //MARK: - Private variables
    
    //MARK: - GUI variables
    
    private lazy var stepLabel: UILabel = {
        var label = UILabel()
        label.text = "шаг 1 из 3"
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var bigImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.backgroundColor = .init(rgb: 0x219653)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        var label = UILabel()
        label.text = "Somoni - будет показывать вам самый выгодный курс по переводам из России в Таджикистан"
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 24, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        var label = UILabel()
        label.text = " "
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .white
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
        self.bigImageView.snp.makeConstraints { (make) in
            make.top.equalTo(self.stepLabel.snp.bottom).offset(16)
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(350)
        }
        self.titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.bigImageView.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(24)
        }
        self.continueButton.snp.makeConstraints { (make) in
            make.top.greaterThanOrEqualTo(self.titleLabel.snp.bottom).offset(24)
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
        self.view.addSubview(self.bigImageView)
        self.view.addSubview(self.titleLabel)
        self.view.addSubview(self.descriptionLabel)
        self.view.addSubview(self.continueButton)
    }
    
    //MARK: - Actions
    
    @objc private func continueButtonTapped() {
        if let parent = self.parent as? OnboardingPageViewController {
            parent.setViewControllers([parent.pages[1]], direction: .forward, animated: true, completion: nil)
        }
    }
    
}

