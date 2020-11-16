//
//  OnboardingCurrencyPlainModeView.swift
//  CurrencyApp
//
//  Created by Humo Programmer on 10/14/20.
//

import UIKit

class CurrencyPlainModeView: UIView {
    
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
    
    private lazy var firstLabel: UILabel = {
        var label = UILabel()
        label.text = "1 RUB  →"
        label.textColor = .black
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var secondLabel: UILabel = {
        var label = UILabel()
        label.text = "0.1380 TJS"
        label.textColor = .black
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        imageView.contentMode = .scaleToFill
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
        self.normal()
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
        self.firstLabel.snp.updateConstraints { (make) in
            make.left.equalToSuperview().inset(24)
            make.centerY.equalToSuperview()
        }
        self.secondLabel.snp.updateConstraints { (make) in
            make.left.equalTo(self.firstLabel.snp.right).offset(16)
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
        self.containerView.addSubview(self.firstLabel)
        self.containerView.addSubview(self.secondLabel)
        self.containerView.addSubview(self.checkmarkImageView)
    }
    
    //MARK: - Helpers
    
    func normal() {
        UIView.animate(withDuration: 0.5) {
            self.checkmarkImageView.isHidden = true
            self.containerView.layer.borderWidth = 1.6
            self.containerView.layer.borderColor = UIColor.init(rgb: 0xE0E0E0).cgColor
            self.firstLabel.alpha = 0.6
            self.secondLabel.alpha = 0.6
            self.containerView.layer.shadowOpacity = 0
        }
    }
    
    func highlighted() {
        self.layoutSubviews()
        UIView.animate(withDuration: 0.5) {
            self.checkmarkImageView.isHidden = false
            self.containerView.layer.borderWidth = 3.0
            self.containerView.layer.borderColor = UIColor.init(rgb: 0x219653).cgColor
            self.firstLabel.alpha = 1
            self.secondLabel.alpha = 1
            self.containerView.layer.shadowOpacity = 1
        }
    }
    
}
