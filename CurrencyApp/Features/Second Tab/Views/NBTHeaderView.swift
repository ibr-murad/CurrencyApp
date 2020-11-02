//
//  NBTHeaderView.swift
//  CurrencyApp
//
//  Created by Humo Programmer  on 10/29/20.
//

import UIKit

class NBTHeaderView: UITableViewHeaderFooterView {
    
    //MARK: - GUI variables
    
    private lazy var containerView: UIView = {
        var view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var currencyLabel: UILabel = {
        var label = UILabel()
        label.text = "Валюта"
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = Colors.textBlackDisabled.color()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var buyLabel: UILabel = {
        var label = UILabel()
        label.text = "Покупка"
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = Colors.textBlackDisabled.color()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var sellLabel: UILabel = {
        var label = UILabel()
        label.text = "Продажа"
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = Colors.textBlackDisabled.color()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var lineView: UIView = {
        var view = UIView()
        view.backgroundColor = .groupTableViewBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK: - Initialization
    
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        self.contentView.backgroundColor = .init(rgb: 0xF3F4F5)
        self.addSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.addSubviews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.containerView.roundedCorners([.topLeft, .topRight], radius: 12)
    }
    
    //MARK: - Constraints
    
    override func updateConstraints() {
        self.containerView.snp.updateConstraints { (make) in
            make.edges.equalToSuperview()
        }
        self.currencyLabel.snp.updateConstraints { (make) in
            make.top.left.bottom.equalToSuperview().inset(20)
        }
        self.buyLabel.snp.updateConstraints { (make) in
            make.top.bottom.equalToSuperview().inset(20)
        }
        self.sellLabel.snp.updateConstraints { (make) in
            make.top.bottom.equalToSuperview().inset(20)
            make.right.equalToSuperview().inset(20)
            make.left.equalTo(self.buyLabel.snp.right).offset(40)
        }
        self.lineView.snp.updateConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
        super.updateConstraints()
    }
    
    //MARK: - Setters
    
    private func addSubviews() {
        self.addSubview(self.containerView)
        self.containerView.addSubview(self.currencyLabel)
        self.containerView.addSubview(self.buyLabel)
        self.containerView.addSubview(self.sellLabel)
        self.containerView.addSubview(self.lineView)
    }
    
}


/*class NBTHeaderView: UIView {
    
    //MARK: - GUI variables
    
    private lazy var containerView: UIView = {
        var view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var currencyLabel: UILabel = {
        var label = UILabel()
        label.text = "Валюта"
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = Colors.textBlackDisabled.color()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var buyLabel: UILabel = {
        var label = UILabel()
        label.text = "Покупка"
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = Colors.textBlackDisabled.color()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var sellLabel: UILabel = {
        var label = UILabel()
        label.text = "Продажа"
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = Colors.textBlackDisabled.color()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var lineView: UIView = {
        var view = UIView()
        view.backgroundColor = .groupTableViewBackground
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.containerView.roundedCorners([.topLeft, .topRight], radius: 12)
    }
    
    //MARK: - Constraints
    
    override func updateConstraints() {
        self.containerView.snp.updateConstraints { (make) in
            make.edges.equalToSuperview()
        }
        self.currencyLabel.snp.updateConstraints { (make) in
            make.top.left.bottom.equalToSuperview().inset(20)
        }
        self.buyLabel.snp.updateConstraints { (make) in
            make.top.bottom.equalToSuperview().inset(20)
        }
        self.sellLabel.snp.updateConstraints { (make) in
            make.top.bottom.equalToSuperview().inset(20)
            make.right.equalToSuperview().inset(20)
            make.left.equalTo(self.buyLabel.snp.right).offset(40)
        }
        self.lineView.snp.updateConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
        super.updateConstraints()
    }
    
    //MARK: - Setters
    
    private func addSubviews() {
        self.addSubview(self.containerView)
        self.containerView.addSubview(self.currencyLabel)
        self.containerView.addSubview(self.buyLabel)
        self.containerView.addSubview(self.sellLabel)
        self.containerView.addSubview(self.lineView)
    }
    
}*/
