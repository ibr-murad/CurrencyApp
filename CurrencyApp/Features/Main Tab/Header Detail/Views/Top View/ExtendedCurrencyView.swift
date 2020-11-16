//
//  ExtendedCurrencyView.swift
//  CurrencyApp
//
//  Created by Humo Programmer  on 11/12/20.
//

import UIKit

class ExtendedCurrencyView: UIView {
    
    //MARK: - Public variables
    
    //MARK: - Private variables
    
    //MARK: - GUI variables
    
    private lazy var currencyLabel: UILabel = {
        var label = UILabel()
        label.text = "Валюта"
        label.textAlignment = .center
        label.textColor = UIColor.white.withAlphaComponent(0.8)
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var buyLabel: UILabel = {
        var label = UILabel()
        label.text = "Покупка"
        
        label.textAlignment = .center
        label.textColor = UIColor.white.withAlphaComponent(0.8)
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var sellLabel: UILabel = {
        var label = UILabel()
        label.text = "Продажа"
        label.textAlignment = .center
        label.textColor = UIColor.white.withAlphaComponent(0.8)
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var lineView: UIView = {
        var view = UIView()
        view.backgroundColor = .init(rgb: 0xFFFFFF, alpha: 0.12)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var firstItemView: ExtendedCurrencyItemView = {
        var view = ExtendedCurrencyItemView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var secondItemView: ExtendedCurrencyItemView = {
        var view = ExtendedCurrencyItemView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var thirdItemView: ExtendedCurrencyItemView = {
        var view = ExtendedCurrencyItemView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
    
    func initView(_ models: [CurrencyModel]) {
        if models.count >= 3 {
            self.firstItemView.initView(models[0])
            self.secondItemView.initView(models[1])
            self.thirdItemView.initView(models[2])
        } else if models.count <= 2 {
            self.firstItemView.initView(models[0])
            self.secondItemView.isHidden = true
            self.thirdItemView.isHidden = true
        }
        self.setNeedsUpdateConstraints()
    }
    
    //MARK: - Constraints
    
    override func updateConstraints() {
        self.currencyLabel.snp.updateConstraints { (make) in
            make.top.left.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.width * 0.33)
        }
        self.buyLabel.snp.updateConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalTo(self.currencyLabel.snp.right)
            make.right.equalTo(self.sellLabel.snp.left)
        }
        self.sellLabel.snp.updateConstraints { (make) in
            make.top.right.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.width * 0.33)
        }
        self.lineView.snp.updateConstraints { (make) in
            make.top.equalTo(self.currencyLabel.snp.bottom).offset(24)
            make.left.right.equalToSuperview()
            make.height.equalTo(1)
        }
        self.firstItemView.snp.updateConstraints { (make) in
            make.top.equalTo(self.lineView.snp.bottom).offset(24)
            make.left.right.equalToSuperview()
        }
        self.secondItemView.snp.updateConstraints { (make) in
            make.top.equalTo(self.firstItemView.snp.bottom).offset(24)
            make.left.right.equalToSuperview()
        }
        self.thirdItemView.snp.updateConstraints { (make) in
            make.top.equalTo(self.secondItemView.snp.bottom).offset(24)
            make.left.right.bottom.equalToSuperview()
        }
        
        super.updateConstraints()
    }
    
    //MARK: - Setters
    
    private func addSubviews() {
        self.addSubview(self.currencyLabel)
        self.addSubview(self.buyLabel)
        self.addSubview(self.sellLabel)
        self.addSubview(self.lineView)
        self.addSubview(self.firstItemView)
        self.addSubview(self.secondItemView)
        self.addSubview(self.thirdItemView)
    }
    
}
