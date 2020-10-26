//
//  OnboardingCurrencyView.swift
//  CurrencyApp
//
//  Created by Humo Programmer  on 10/13/20.
//

import UIKit

class OnboardingCurrencyView: UIView {
    
    //MARK: - Public variables
    
    //MARK: - Private variables
    
    //MARK: - GUI variables
    
    private lazy var firstItem: OnboardingCurrencyItemView = {
        var view = OnboardingCurrencyItemView()
        let tap = UITapGestureRecognizer(
            target: self, action: #selector(self.firstItemTapped))
        view.addGestureRecognizer(tap)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var secondItem: OnboardingCurrencyItemView = {
        var view = OnboardingCurrencyItemView()
        let tap = UITapGestureRecognizer(
            target: self, action: #selector(self.secondItemTapped))
        view.addGestureRecognizer(tap)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var thirdItem: OnboardingCurrencyItemView = {
        var view = OnboardingCurrencyItemView()
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
    
    func initView(data: [OnboardingCurrencyItemModel]) {
        self.firstItem.initView(image: data[0].image, code: data[0].code, name: data[0].name)
        self.secondItem.initView(image: data[1].image, code: data[1].code, name: data[1].name)
        self.thirdItem.initView(image: data[2].image, code: data[2].code, name: data[2].name)
        
        self.setNeedsUpdateConstraints()
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        print("a")
        print(self.firstItem.bounds)
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
    }
    
    @objc private func secondItemTapped() {
        self.firstItem.normal()
        self.secondItem.highlighted()
        self.thirdItem.normal()
    }
    
    @objc private func thirdItemTapped() {
        self.firstItem.normal()
        self.secondItem.normal()
        self.thirdItem.highlighted()
    }
    
}
