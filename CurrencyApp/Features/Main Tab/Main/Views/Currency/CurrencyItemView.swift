//
//  CurrencyItemView.swift
//  CurrencyApp
//
//  Created by Humo Programmer  on 10/7/20.
//

import UIKit

class CurrencyItemView: UIView {

    //MARK: - GUI variables
    
    private lazy var titleLabel: UILabel = {
        var label = UILabel()
        label.text = "Валюта"
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = Colors.textBlackMiddle.color()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        var label = UILabel()
        label.text = "1 RUB"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = Colors.textBlackHight.color()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
    
    func initView(_ title: String, _ description: String) {
        self.titleLabel.text = title
        self.descriptionLabel.text = description
    }
    
    //MARK: - Constraints
    
    override func updateConstraints() {
        self.titleLabel.snp.updateConstraints { (make) in
            make.top.left.right.equalToSuperview()
        }
        self.descriptionLabel.snp.updateConstraints { (make) in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(4)
            make.left.right.bottom.equalToSuperview()
        }
        super.updateConstraints()
    }
    
    //MARK: - Setters
    
    private func addSubviews() {
        self.addSubview(self.titleLabel)
        self.addSubview(self.descriptionLabel)
    }
    
    func setColor(_ colors: [UIColor]) {
        self.titleLabel.textColor = colors[0]
        self.descriptionLabel.textColor = colors[1]
        
        self.layoutIfNeeded()
    }
    
    func setFont(_ font: UIFont) {
        self.descriptionLabel.font = font
        
        self.layoutIfNeeded()
    }
    
}
