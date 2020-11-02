//
//  NBTTableViewCell.swift
//  CurrencyApp
//
//  Created by Humo Programmer  on 10/28/20.
//

import UIKit

class NBTTableViewCell1: UITableViewCell {
    
    //MARK: - Public variables
    
    static let identifier = "NBTTableViewCell"
    
    //MARK: - GUI variables

    private lazy var currencyImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(named: "rub")
        imageView.isWindlessable = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var currencyNameLabel: UILabel = {
        var label = UILabel()
        label.text = "RUB"
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = Colors.textBlackHight.color()
        label.isWindlessable = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
    
    private lazy var currencySellLabel: UILabel = {
        var label = UILabel()
        label.text = "0.1350"
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = Colors.textBlackHight.color()
        label.isWindlessable = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var currencyBuyLabel: UILabel = {
        var label = UILabel()
        label.text = "0.1380"
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = Colors.textBlackHight.color()
        label.isWindlessable = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.selectionStyle = .none
        self.clipsToBounds = true
        self.addSubviews()
        self.setNeedsUpdateConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.addSubviews()
    }
    
    func initCell(model: NBTRateModel) {
        self.currencyNameLabel.text = model.char_code
        self.currencyBuyLabel.text = "\(model.value)"
        
        self.setNeedsUpdateConstraints()
    }
    
    //MARK: - Constraints
    
    override func updateConstraints() {
        self.currencyImageView.snp.updateConstraints { (make) in
            make.top.left.equalToSuperview().inset(20)
            make.bottom.lessThanOrEqualToSuperview().inset(20)
            make.size.equalTo(CGSize(width: 32, height: 24))
        }
        self.currencyNameLabel.snp.updateConstraints { (make) in
            make.left.equalTo(self.currencyImageView.snp.right).offset(12)
            make.centerY.equalToSuperview()
        }
        
        self.arrorwImageContainerView.snp.updateConstraints { (make) in
            make.left.equalTo(self.currencyNameLabel.snp.right)
            make.right.equalTo(self.currencyBuyLabel.snp.left)
            make.centerY.equalToSuperview()
        }
        self.arrorwImageView.snp.remakeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 28, height: 22))
        }
        
        self.currencyBuyLabel.snp.updateConstraints { (make) in
            make.centerY.equalToSuperview()
        }
        self.currencySellLabel.snp.updateConstraints { (make) in
            make.right.equalToSuperview().inset(20)
            make.left.equalTo(self.currencyBuyLabel.snp.right).offset(40)
            make.centerY.equalToSuperview()
        }
        
        super.updateConstraints()
    }
    
    //MARK: - Setters
    
    private func addSubviews() {
        self.contentView.addSubview(self.currencyImageView)
        self.contentView.addSubview(self.currencyNameLabel)
        self.contentView.addSubview(self.arrorwImageContainerView)
        self.arrorwImageContainerView.addSubview(self.arrorwImageView)
        self.contentView.addSubview(self.currencyBuyLabel)
        self.contentView.addSubview(self.currencySellLabel)
    }
    
}
