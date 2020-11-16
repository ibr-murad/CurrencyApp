//
//  ThirdTabTableViewCell.swift
//  CurrencyApp
//
//  Created by Humo Programmer on 11/2/20.
//

import UIKit
import Kingfisher

class NBTTableViewCell: UITableViewCell {
    
    //MARK: - Public variables
    
    static let identifier = "NBTTableViewCell"
    
    //MARK: - GUI variables
    
    private lazy var containerView: UIView = {
        var view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var currencyImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(named: "rub")
        imageView.isWindlessable = true
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.2).cgColor
        imageView.layer.cornerRadius = 16
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var currencyNameView: UIView = {
        var view = UIView()
        view.isWindlessable = true
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var currencyCodeNameLabel: UILabel = {
        var label = UILabel()
        label.text = "RUB"
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = Colors.textBlackHight.color()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var currencyNameLabel: UILabel = {
        var label = UILabel()
        label.text = "Российский рубль"
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = Colors.textBlackMiddle.color()
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var currencyValueContainerView: UIView = {
        var view = UIView()
        view.clipsToBounds = false
        view.layer.cornerRadius = 6
        view.isWindlessable = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var currencyValueLabel: UILabel = {
        var label = UILabel()
        label.text = "0.1350"
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textAlignment = .right
        label.numberOfLines = 1
        label.textColor = Colors.textBlackHight.color()
        label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var separatorView: UIView = {
        var view = UIView()
        view.backgroundColor = .groupTableViewBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.selectionStyle = .none
        self.addSubviews()
        self.setNeedsUpdateConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.addSubviews()
    }
    
    func initCell(model: NBTRateModel) {
        self.currencyCodeNameLabel.text = "\(model.nominal) \(model.name)"
        self.currencyNameLabel.text = model.name
        self.currencyValueLabel.text = "\(model.value) TJS"
        if let imageURL = URL(string: model.flag) {
            self.currencyImageView.kf.setImage(with: imageURL)
        }
        
        self.setNeedsUpdateConstraints()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.separatorView.isHidden = false
    }
    
    //MARK: - Constraints
    
    override func updateConstraints() {
        self.containerView.snp.updateConstraints { (make) in
            make.edges.equalToSuperview()
        }
        self.currencyImageView.snp.updateConstraints { (make) in
            make.top.equalTo(self.currencyNameView.snp.top)
            make.left.equalToSuperview().inset(20)
            make.size.equalTo(CGSize(width: 32, height: 32))
        }
        self.currencyNameView.snp.updateConstraints { (make) in
            make.left.equalTo(self.currencyImageView.snp.right).offset(12)
            make.centerY.equalToSuperview()
        }
        self.currencyCodeNameLabel.snp.updateConstraints { (make) in
            make.top.left.equalToSuperview()
        }
        self.currencyNameLabel.snp.updateConstraints { (make) in
            make.top.equalTo(self.currencyCodeNameLabel.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
        self.currencyValueContainerView.snp.updateConstraints { (make) in
            make.left.equalTo(self.currencyNameView.snp.right).offset(8)
            make.right.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
        }
        self.currencyValueLabel.snp.updateConstraints { (make) in
            make.edges.equalToSuperview()
        }
        self.separatorView.snp.updateConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
        super.updateConstraints()
    }
    
    //MARK: - Setters
    
    private func addSubviews() {
        self.contentView.addSubview(self.containerView)
        self.contentView.addSubview(self.separatorView)
        self.containerView.addSubview(self.currencyImageView)
        self.containerView.addSubview(self.currencyNameView)
        self.currencyNameView.addSubview(self.currencyCodeNameLabel)
        self.currencyNameView.addSubview(self.currencyNameLabel)
        self.containerView.addSubview(self.currencyValueContainerView)
        self.currencyValueContainerView.addSubview(self.currencyValueLabel)
    }
    
}
