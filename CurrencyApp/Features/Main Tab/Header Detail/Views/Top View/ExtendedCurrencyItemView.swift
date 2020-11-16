//
//  ExtendedCurrencyItemView.swift
//  CurrencyApp
//
//  Created by Humo Programmer  on 11/12/20.
//

import UIKit

class ExtendedCurrencyItemView: UIView {
    
    //MARK: - Public variables
    
    //MARK: - Private variables
    
    //MARK: - GUI variables
    
    private lazy var currencyLabel: UILabel = {
        var label = UILabel()
        label.text = "1 RUB"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 1
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var buyLabel: UILabel = {
        var label = UILabel()
        label.text = "0.1350"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 1
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var sellLabel: UILabel = {
        var label = UILabel()
        label.text = "0.1350"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 1
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var lineView: UIView = {
        var view = UIView()
        view.backgroundColor = .init(rgb: 0xFFFFFF, alpha: 0.12)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var arrorwImageContainerView: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var arrorwImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.contentMode = .center
        imageView.image = UIImage(named: "arrow")
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
    
    func initView(_ model: CurrencyModel) {
        self.currencyLabel.text = "1 " + model.name
        self.buyLabel.text = model.buy
        self.sellLabel.text = model.sell
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
            make.top.equalTo(self.sellLabel.snp.bottom).offset(24)
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
        /*self.arrorwImageContainerView.snp.remakeConstraints { (make) in
            make.left.equalTo(self.firstItem.snp.right)
            make.right.equalTo(self.secondItem.snp.left)
            make.bottom.equalToSuperview()
        }
        self.arrorwImageView.snp.remakeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 28, height: 22))
        }*/
        super.updateConstraints()
    }
    
    //MARK: - Setters
    
    private func addSubviews() {
        self.addSubview(self.currencyLabel)
        self.addSubview(self.buyLabel)
        self.addSubview(self.sellLabel)
        self.addSubview(self.lineView)
    }
    
}
