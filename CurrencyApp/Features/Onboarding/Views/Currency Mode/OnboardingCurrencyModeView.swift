//
//  OnboardingCurrencyModeView.swift
//  CurrencyApp
//
//  Created by Humo Programmer  on 10/13/20.
//

import UIKit

class OnboardingCurrencyModeView: UIView {
    
    //MARK: - Public variables
    
    //MARK: - Private variables
    
    //MARK: - GUI variables
    
    private lazy var firstItem: OnboardingCurrencyPlainModeView = {
        var view = OnboardingCurrencyPlainModeView()
        view.initView(mode: "Простой режим")
        let tap = UITapGestureRecognizer(
            target: self, action: #selector(self.firstItemTapped))
        view.addGestureRecognizer(tap)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var secondItem: OnboardingCurrencyExtendedModeView = {
        var view = OnboardingCurrencyExtendedModeView()
        view.initView(mode: "Расширенный режим")
        let tap = UITapGestureRecognizer(
            target: self, action: #selector(self.secondItemTapped))
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
    
    func initView(data: [OnboardingCurrencyItemModel]) {
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.firstItem.highlighted()
    }
    
    //MARK: - Constraints
    
    override func updateConstraints() {
        self.firstItem.snp.updateConstraints { (make) in
            make.top.left.right.equalToSuperview()
        }
        self.secondItem.snp.updateConstraints { (make) in
            make.top.equalTo(self.firstItem.snp.bottom).offset(24)
            make.left.right.bottom.equalToSuperview()
        }
        super.updateConstraints()
    }
    
    //MARK: - Setters
    
    private func addSubviews() {
        self.addSubview(self.firstItem)
        self.addSubview(self.secondItem)
    }
    
    //MARK: - Actions
    
    @objc private func firstItemTapped() {
        self.firstItem.highlighted()
        self.secondItem.normal()
    }
    
    @objc private func secondItemTapped() {
        self.firstItem.normal()
        self.secondItem.highlighted()
    }
    
}
