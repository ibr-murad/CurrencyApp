//
//  MainTableViewCell.swift
//  CurrencyApp
//
//  Created by Humo Programmer on 10/8/20.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "MainTableViewCell"
    
    //MARK: - Public variables
    
    var currencyName: String {
        if self.type == .type1 {
            return Settings.shared.defaultCurrency.rawValue
        }
         return DefaultCurrency.rub.rawValue
    }
    var deteailSelected: ((String) -> Void)?
    var type: MainDataType = .type1
    
    //MARK: - Private variables
    
    private var model: BankRatesModel?
    private var isLayersConfigured = false
    
    //MARK: - GUI variables
    
    lazy var containerView: UIView = {
        var view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var logoConteinerView: UIView = {
        var view = UIView()
        view.isWindlessable = true
        view.clipsToBounds = false
        view.layer.cornerRadius = 6
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var logoImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "humo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var logoNameLabel: UILabel = {
        var label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.textColor = Colors.textBlackMain.color()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var lineView: UIView = {
        var view = UIView()
        view.backgroundColor = .init(rgb: 0xF2F2F2)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var currencyView: CurrencyView = {
        var view = CurrencyView()
        view.isWindlessable = true
        view.clipsToBounds = false
        view.layer.cornerRadius = 12
        view.setFont(.systemFont(ofSize: 20, weight: .medium))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var detailButton: UIButton = {
        var button = UIButton(type: .system)
        button.setImage(UIImage(named: "detail"), for: .normal)
        button.tintColor = Colors.textBlackMiddle.color()
        button.addTarget(self, action: #selector(self.detailButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //MARK: - Initialization

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        self.backgroundColor = .init(rgb: 0xF3F4F5)
        
        self.addSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.addSubviews()
    }
    
    func initCell(model: BankRatesModel) {
        self.model = model
        for i in 0..<model.currency.count {
            if model.currency[i].name == self.currencyName {
                self.currencyView.initView(model: model.currency[i])
                break
            }
        }
        self.logoNameLabel.text = model.name
        if let url = URL(string: model.icon) {
            self.logoImageView.kf.setImage(with: url)
        }
        self.setNeedsUpdateConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if !self.isLayersConfigured && self.containerView.bounds != .zero {
            self.containerView.dropShadow(
                color: .init(rgb: 0x000000, alpha: 0.04),
                opacity: 1, offSet: .init(width: 0, height: 1), radius: 2)
            self.isLayersConfigured = true
        }
    }
    
    //MARK: - Constraints
    
    override func updateConstraints() {
        self.containerView.snp.updateConstraints { (make) in
            make.top.bottom.equalToSuperview().inset(8)
            make.left.right.equalToSuperview().inset(16)
        }
        self.logoConteinerView.snp.updateConstraints { (make) in
            make.top.left.equalToSuperview().inset(20)
            make.height.equalTo(24)
            make.width.greaterThanOrEqualTo(100)
        }
        self.logoImageView.snp.updateConstraints { (make) in
            make.top.left.bottom.equalToSuperview()
            make.size.equalTo(24)
        }
        self.logoNameLabel.snp.updateConstraints { (make) in
            make.top.right.bottom.equalToSuperview()
            make.left.equalTo(self.logoImageView.snp.right).offset(8)
        }
        self.detailButton.snp.updateConstraints { (make) in
            make.left.greaterThanOrEqualTo(self.logoConteinerView.snp.right).offset(16)
            make.right.equalToSuperview().inset(20)
            make.centerY.equalTo(self.logoConteinerView.snp.centerY)
            make.size.equalTo(CGSize(width: 40, height: 40))
        }
        self.lineView.snp.updateConstraints { (make) in
            make.top.equalTo(self.logoConteinerView.snp.bottom).offset(16)
            make.left.right.equalToSuperview()
            make.height.equalTo(1)
        }
        self.currencyView.snp.updateConstraints { (make) in
            make.top.equalTo(self.lineView.snp.bottom).offset(12)
            make.left.right.bottom.equalToSuperview().inset(20)
        }
        super.updateConstraints()
    }
    
    //MARK: - Setters
    
    private func addSubviews() {
        self.contentView.addSubview(self.containerView)
        self.containerView.addSubview(self.logoConteinerView)
        self.logoConteinerView.addSubview(self.logoImageView)
        self.logoConteinerView.addSubview(self.logoNameLabel)
        self.containerView.addSubview(self.detailButton)
        self.containerView.addSubview(self.lineView)
        self.containerView.addSubview(self.currencyView)
    
        self.setNeedsUpdateConstraints()
    }
    
    //MARK: - Actions
    
    @objc private func detailButtonTapped() {
        self.deteailSelected?("")
    }
    
}
