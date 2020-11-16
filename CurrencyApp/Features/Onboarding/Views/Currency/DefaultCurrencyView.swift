//
//  OnboardingCurrencyView.swift
//  CurrencyApp
//
//  Created by Humo Programmer on 10/13/20.
//

import UIKit

class DefaultCurrencyView: UIView {
    
    //MARK: - Public variables
    
    var selectedCurrency: DefaultCurrency?
    
    //MARK: - GUI variables
    
    private lazy var firstItem: DefaultCurrencyItemView = {
        var view = DefaultCurrencyItemView()
        let tap = UITapGestureRecognizer(
            target: self, action: #selector(self.firstItemTapped))
        view.addGestureRecognizer(tap)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var secondItem: DefaultCurrencyItemView = {
        var view = DefaultCurrencyItemView()
        let tap = UITapGestureRecognizer(
            target: self, action: #selector(self.secondItemTapped))
        view.addGestureRecognizer(tap)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var thirdItem: DefaultCurrencyItemView = {
        var view = DefaultCurrencyItemView()
        let tap = UITapGestureRecognizer(
            target: self, action: #selector(self.thirdItemTapped))
        view.addGestureRecognizer(tap)
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
    
    func initView(data: [CurrencyItemModel]) {
        self.firstItem.initView(image: data[0].image, code: data[0].code, name: data[0].name)
        self.secondItem.initView(image: data[1].image, code: data[1].code, name: data[1].name)
        self.thirdItem.initView(image: data[2].image, code: data[2].code, name: data[2].name)
        
        self.setNeedsUpdateConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if Settings.shared.defaultCurrency == .rub {
            self.firstItem.highlighted()
        } else if Settings.shared.defaultCurrency == .usd {
            self.secondItem.highlighted()
        } else {
            self.thirdItem.highlighted()
        }
    }
    
    //MARK: - Constraints
    
    override func updateConstraints() {
        self.firstItem.snp.updateConstraints { (make) in
            make.top.left.right.equalToSuperview()
        }
        self.secondItem.snp.updateConstraints { (make) in
            make.top.equalTo(self.firstItem.snp.bottom).offset(16)
            make.left.right.equalToSuperview()
        }
        self.thirdItem.snp.updateConstraints { (make) in
            make.top.equalTo(self.secondItem.snp.bottom).offset(16)
            make.left.right.bottom.equalToSuperview()
        }
        super.updateConstraints()
    }
    
    //MARK: - Setters
    
    private func addSubviews() {
        self.addSubview(self.firstItem)
        self.addSubview(self.secondItem)
        self.addSubview(self.thirdItem)
    }
    
    //MARK: - Actions
    
    @objc private func firstItemTapped() {
        self.firstItem.highlighted()
        self.secondItem.normal()
        self.thirdItem.normal()
        self.selectedCurrency = .rub
    }
    
    @objc private func secondItemTapped() {
        self.firstItem.normal()
        self.secondItem.highlighted()
        self.thirdItem.normal()
        self.selectedCurrency = .usd
    }
    
    @objc private func thirdItemTapped() {
        self.firstItem.normal()
        self.secondItem.normal()
        self.thirdItem.highlighted()
        self.selectedCurrency = .eur
    }
    
}
