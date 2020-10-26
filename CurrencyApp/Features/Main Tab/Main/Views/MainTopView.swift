//
//  MainTopView.swift
//  CurrencyApp
//
//  Created by Humo Programmer  on 10/7/20.
//

import UIKit
import SnapKit

class MainHeaderView: UIView {
    
    //MARK: - GUI variables
    
    private lazy var containerView: UIView = {
        var view = UIView()
        view.layer.cornerRadius = 20
        view.backgroundColor = .red
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var logoView: UIView = {
        var view = UIView()
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var logoImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "humo1")
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
    
    private lazy var shareImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "share")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var lineView1: UIView = {
        var view = UIView()
        view.backgroundColor = .init(white: 1, alpha: 0.12)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var lineView2: UIView = {
        var view = UIView()
        view.backgroundColor = .init(white: 1, alpha: 0.12)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var lineView3: UIView = {
        var view = UIView()
        view.backgroundColor = .init(white: 1, alpha: 0.12)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var titleLabel: UILabel = {
        var label = UILabel()
        label.text = "Самый выгодный курс по переводам"
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var currencyItemsView: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var currencyItemView1 = CurrencyItemView()
    private lazy var currencyItemView2 = CurrencyItemView()
    private lazy var currencyItemView3 = CurrencyItemView()
    
    //MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.addSubviews()
    }
    
    //MARK: - Constraints
    
    override func updateConstraints() {
        self.containerView.snp.updateConstraints { (make) in
            make.edges.equalToSuperview()
        }
        self.logoView.snp.updateConstraints { (make) in
            make.top.left.equalToSuperview().inset(20)
        }
        self.logoImageView.snp.updateConstraints { (make) in
            make.top.left.bottom.equalToSuperview()
            make.size.equalTo(24)
        }
        self.logoLabel.snp.updateConstraints { (make) in
            make.left.equalTo(self.logoImageView.snp.right).offset(5)
            make.right.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        self.shareImageView.snp.updateConstraints { (make) in
            make.right.equalToSuperview().inset(20)
            make.centerY.equalTo(self.logoView.snp.centerY)
            make.size.equalTo(20)
        }
        self.lineView1.snp.updateConstraints { (make) in
            make.top.equalTo(self.logoView.snp.bottom).offset(20)
            make.left.right.equalToSuperview()
            make.height.equalTo(1)
        }
        self.titleLabel.snp.updateConstraints { (make) in
            make.top.equalTo(self.lineView1.snp.bottom).offset(8)
            make.left.equalToSuperview().inset(20)
            make.right.equalToSuperview()
        }
        self.lineView2.snp.updateConstraints { (make) in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(8)
            make.left.right.equalToSuperview()
            make.height.equalTo(1)
        }
        self.currencyItemsView.snp.updateConstraints { (make) in
            make.top.equalTo(self.lineView2.snp.bottom).offset(20)
            make.left.equalToSuperview().inset(20)
        }
        self.currencyItemView1.snp.updateConstraints { (make) in
            make.top.left.bottom.equalToSuperview()
        }
        self.currencyItemView2.snp.updateConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalTo(self.currencyItemView1.snp.right).offset(30)
            make.bottom.equalToSuperview()
        }
        self.currencyItemView3.snp.updateConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalTo(self.currencyItemView2.snp.right).offset(30)
            make.bottom.equalToSuperview()
        }
        self.lineView3.snp.updateConstraints { (make) in
            make.top.equalTo(self.currencyItemsView.snp.bottom).offset(20)
            make.left.right.equalToSuperview()
            make.height.equalTo(1)
            make.bottom.equalToSuperview().inset(20)
        }
        super.updateConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.addSublayerForContainerView()
    }
    
    //MARK: - Setters
    
    private func addSubviews() {
        self.addSubview(self.containerView)
        self.containerView.addSubview(self.logoView)
        self.logoView.addSubview(self.logoImageView)
        self.logoView.addSubview(self.logoLabel)
        self.containerView.addSubview(self.shareImageView)
        self.containerView.addSubview(self.lineView1)
        self.containerView.addSubview(self.titleLabel)
        self.containerView.addSubview(self.lineView2)
        self.containerView.addSubview(self.currencyItemsView)
        self.currencyItemsView.addSubview(self.currencyItemView1)
        self.currencyItemsView.addSubview(self.currencyItemView2)
        self.currencyItemsView.addSubview(self.currencyItemView3)
        self.containerView.addSubview(self.lineView3)
    }
    
    private func addSublayerForContainerView() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.containerView.bounds
        let color1 = UIColor(red: 222/255, green: 80/255, blue: 0/255, alpha: 1).cgColor
        let color2 = UIColor(red: 252/255, green: 141/255, blue: 38/255, alpha: 1).cgColor
        gradientLayer.colors = [color1, color2]
        gradientLayer.startPoint = .init(x: 0.25, y: 0.5)
        gradientLayer.endPoint = .init(x: 0.75, y: 0.5)
        self.containerView.layer.insertSublayer(gradientLayer, at: 0)
    }
    
}
