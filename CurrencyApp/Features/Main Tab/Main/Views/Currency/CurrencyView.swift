//
//  CurrencyView.swift
//  CurrencyApp
//
//  Created by Humo Programmer on 10/8/20.
//

import UIKit

class CurrencyView: UIView {
    
    //MARK: - GUI variables
    
    //MARK: Plain mode
    
    private lazy var firstLabel:  UILabel = {
        var label = UILabel()
        label.text = "1 RUB  → "
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = Colors.textBlackHight.color()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var secondLabel: UILabel = {
        var label = UILabel()
        label.text = "0.1380 TJS"
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = Colors.textBlackHight.color()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: Extented mode
    
    private lazy var firstItem: CurrencyItemView = {
        var view = CurrencyItemView()
        view.initView("Валюта", "1 RUB  →")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var secondItem: CurrencyItemView = {
        var view = CurrencyItemView()
        view.initView("Покупка", "0.1350")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var thirdItem: CurrencyItemView = {
        var view = CurrencyItemView()
        view.initView("Продажа", "0.1380")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubviews()
        self.modeUpdated()
        
        NotificationCenter.default.addObserver(
            self, selector: #selector(self.modeUpdated),
            name: .modeUpdated, object: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.addSubviews()
    }
    
    //MARK: - Constraints
    
    override func updateConstraints() {
        self.firstLabel.snp.updateConstraints { (make) in
            make.left.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        self.secondLabel.snp.updateConstraints { (make) in
            make.left.greaterThanOrEqualTo(self.firstLabel.snp.right).offset(20)
            make.centerY.equalToSuperview()
        }
        self.firstItem.snp.updateConstraints { (make) in
            make.top.left.bottom.equalToSuperview()
        }
        self.secondItem.snp.updateConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.greaterThanOrEqualTo(self.firstItem.snp.right).offset(20)
        }
        self.thirdItem.snp.updateConstraints { (make) in
            make.top.bottom.right.equalToSuperview()
            make.left.equalTo(self.secondItem.snp.right).offset(30)
        }
        super.updateConstraints()
    }
    
    //MARK: - Setters
    
    private func addSubviews() {
        self.addSubview(self.firstLabel)
        self.addSubview(self.secondLabel)
        self.addSubview(self.firstItem)
        self.addSubview(self.secondItem)
        self.addSubview(self.thirdItem)
    }
    
    func setColor(_ colors: [UIColor]) {
        self.firstLabel.textColor = colors[1]
        self.secondLabel.textColor = colors[1]
        self.firstItem.setColor(colors)
        self.secondItem.setColor(colors)
        self.thirdItem.setColor(colors)
    }
    
    //MARK: - Helpers
    
    @objc private func modeUpdated() {
        let isPlainMode = UserDefaults.standard.bool(forKey: "isPlainMode")
        if isPlainMode {
            self.firstLabel.isHidden = false
            self.secondLabel.isHidden = false
            self.firstItem.isHidden = true
            self.secondItem.isHidden = true
            self.thirdItem.isHidden = true
        } else {
            self.firstLabel.isHidden = true
            self.secondLabel.isHidden = true
            self.firstItem.isHidden = false
            self.secondItem.isHidden = false
            self.thirdItem.isHidden = false
        }
    }
    
}
