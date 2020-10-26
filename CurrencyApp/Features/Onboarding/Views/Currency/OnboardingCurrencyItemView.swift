//
//  OnboardingCurrencyItemView.swift
//  CurrencyApp
//
//  Created by Humo Programmer  on 10/13/20.
//

import UIKit

class OnboardingCurrencyItemView: UIView {
    
    //MARK: - Public variables
    
    //MARK: - Private variables
    
    //MARK: - GUI variables
    
    private lazy var containerView: UIView = {
        var view = UIView()
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 1.6
        view.layer.borderColor = UIColor.init(rgb: 0xE0E0E0).cgColor
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var currencyImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 30
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var lablesContainerView: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var currencyCodeLabel: UILabel = {
        var label = UILabel()
        label.textColor = UIColor.black.withAlphaComponent(0.87)
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var currencyNameLabel: UILabel = {
        var label = UILabel()
        label.textColor = UIColor.black.withAlphaComponent(0.35)
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var checkmarkImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "checkmark")
        imageView.isHidden = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    //MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.addSubviews()
    }
    
    func initView(image: UIImage?, code: String, name: String) {
        self.currencyImageView.image = image
        self.currencyCodeLabel.text = code
        self.currencyNameLabel.text = name
        
        self.setNeedsUpdateConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.containerView.dropShadow(
            color: .init(rgb: 0x219653, alpha: 0.25), opacity: 0,
            offSet: CGSize(width: 0, height: 2),
            radius: 4, scale: true)
    }
    
    //MARK: - Constraints
    
    override func updateConstraints() {
        self.containerView.snp.updateConstraints { (make) in
            make.edges.equalToSuperview().inset(6)
        }
        self.currencyImageView.snp.updateConstraints { (make) in
            make.top.bottom.equalToSuperview().inset(28)
            make.left.equalToSuperview().inset(24)
            make.size.equalTo(60)
        }
        self.lablesContainerView.snp.updateConstraints { (make) in
            make.left.equalTo(self.currencyImageView.snp.right).offset(20)
            make.centerY.equalToSuperview()
        }
        self.currencyCodeLabel.snp.updateConstraints { (make) in
            make.top.left.right.equalToSuperview()
        }
        self.currencyNameLabel.snp.updateConstraints { (make) in
            make.top.equalTo(self.currencyCodeLabel.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
        self.checkmarkImageView.snp.updateConstraints { (make) in
            make.top.right.equalToSuperview().inset(16)
            make.size.equalTo(32)
        }
        super.updateConstraints()
    }
    
    //MARK: - Setters
    
    private func addSubviews() {
        self.addSubview(self.containerView)
        self.containerView.addSubview(self.currencyImageView)
        self.containerView.addSubview(self.lablesContainerView)
        self.lablesContainerView.addSubview(self.currencyCodeLabel)
        self.lablesContainerView.addSubview(self.currencyNameLabel)
        self.containerView.addSubview(self.checkmarkImageView)
    }
    
    //MARK: - Helpers
    
    func normal() {
        UIView.animate(withDuration: 0.5) {
            self.containerView.layer.masksToBounds = true
            self.checkmarkImageView.isHidden = true
            self.containerView.layer.borderWidth = 1.6
            self.containerView.layer.borderColor = UIColor.init(rgb: 0xE0E0E0).cgColor
            self.containerView.layer.shadowOpacity = 0
        }
    }
    
    func highlighted() {
        self.layoutSubviews()
        UIView.animate(withDuration: 0.5) {
            self.checkmarkImageView.isHidden = false
            self.containerView.layer.borderWidth = 3.0
            self.containerView.layer.borderColor = UIColor.init(rgb: 0x219653).cgColor
            self.containerView.layer.shadowOpacity = 1
        }
    }
    
}
