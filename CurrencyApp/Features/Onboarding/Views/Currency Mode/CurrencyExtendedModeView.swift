//
//  OnboardingCurrencyExtendedModeView.swift
//  CurrencyApp
//
//  Created by Murodjon Ibrohimovon 10/14/20.
//

import UIKit

class CurrencyExtendedModeView: UIView {
    
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
    
    private lazy var firstItem: CurrencyItemView = {
        let view = CurrencyItemView()
        view.initView("Валюта", "1 RUB  →")
        return view
    }()
    
    private lazy var secondItem: CurrencyItemView = {
        let view = CurrencyItemView()
        view.initView("Покупка", "0.1350")
        return view
    }()
    
    private lazy var thirdItem: CurrencyItemView = {
        let view = CurrencyItemView()
        view.initView("Продажа", "0.1380")
        return view
    }()

    private lazy var modeLabel: UILabel = {
        var label = UILabel()
        label.text = "Простой режим"
        label.textColor = UIColor.black.withAlphaComponent(0.6)
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
        self.normal()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.addSubviews()
    }
    
    func initView(mode title: String) {
        self.modeLabel.text = title
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
            make.top.left.right.equalToSuperview()
            make.height.equalTo(110)
        }
        self.firstItem.snp.updateConstraints { (make) in
            make.left.equalToSuperview().inset(24)
            make.centerY.equalToSuperview()
        }
        self.secondItem.snp.updateConstraints { (make) in
            make.left.equalTo(self.firstItem.snp.right).offset(16)
            make.centerY.equalToSuperview()
        }
        self.thirdItem.snp.updateConstraints { (make) in
            make.left.equalTo(self.secondItem.snp.right).offset(24)
            make.centerY.equalToSuperview()
        }
        self.modeLabel.snp.updateConstraints { (make) in
            make.top.equalTo(self.containerView.snp.bottom).offset(12)
            make.left.right.bottom.equalToSuperview().inset(6)
        }
        self.checkmarkImageView.snp.updateConstraints { (make) in
            make.top.right.equalToSuperview().inset(16)
            make.size.equalTo(24)
        }
        super.updateConstraints()
    }
    
    //MARK: - Setters
    
    private func addSubviews() {
        self.addSubview(self.containerView)
        self.addSubview(self.modeLabel)
        self.containerView.addSubview(self.firstItem)
        self.containerView.addSubview(self.secondItem)
        self.containerView.addSubview(self.thirdItem)
        self.containerView.addSubview(self.checkmarkImageView)
    }
    
    //MARK: - Helpers
    
    func normal() {
        UIView.animate(withDuration: 0.5) {
            self.checkmarkImageView.isHidden = true
            self.containerView.layer.borderWidth = 1.6
            self.containerView.layer.borderColor = UIColor.init(rgb: 0xE0E0E0).cgColor
            self.firstItem.alpha = 0.60
            self.secondItem.alpha = 0.60
            self.thirdItem.alpha = 0.60
            self.containerView.layer.shadowOpacity = 0
        }
    }
    
    func highlighted() {
        self.layoutSubviews()
        UIView.animate(withDuration: 0.5) {
            self.checkmarkImageView.isHidden = false
            self.containerView.layer.borderWidth = 3.0
            self.containerView.layer.borderColor = UIColor.init(rgb: 0x219653).cgColor
            self.firstItem.alpha = 1
            self.secondItem.alpha = 1
            self.thirdItem.alpha = 1
            self.containerView.layer.shadowOpacity = 1
        }
    }
    
}
