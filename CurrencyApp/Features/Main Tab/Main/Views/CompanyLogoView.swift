//
//  CompanyLogoView.swift
//  CurrencyApp
//
//  Created by Humo Programmer  on 10/8/20.
//

import UIKit

class CompanyLogoView: UIView {
    
    //MARK: - GUI variables
    
    private lazy var logoImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "humoWhite")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var logoLabel: UILabel = {
        var label = UILabel()
        label.text = "Ҳумо"
        label.textColor = .white
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.clipsToBounds = true
        self.addSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.addSubviews()
    }
    
    func initView(name: String) {
        self.logoLabel.text = name
        
        self.setNeedsUpdateConstraints()
    }
    
    //MARK: - Constraints
    
    override func updateConstraints() {
        self.logoImageView.snp.updateConstraints { (make) in
            make.top.left.bottom.equalToSuperview()
            make.size.equalTo(24)
        }
        self.logoLabel.snp.updateConstraints { (make) in
            make.left.equalTo(self.logoImageView.snp.right).offset(5)
            make.right.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        super.updateConstraints()
    }
    
    //MARK: - Setters
    
    private func addSubviews() {
        self.addSubview(self.logoImageView)
        self.addSubview(self.logoLabel)
    }
    
    func setColor(_ color: UIColor) {
        self.logoLabel.textColor = color
        self.logoImageView.image = UIImage(named: "humo1")?.with(color: .orange)
    }
    
}
