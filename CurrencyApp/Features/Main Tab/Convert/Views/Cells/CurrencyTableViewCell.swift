//
//  CurrencyTableViewCell.swift
//  CurrencyApp
//
//  Created by Humo Programmer on 10/28/20.
//

import UIKit

class CurrencyTableViewCell: UITableViewCell {
    
    //MARK: - Public variables
    
    static let identifier = "CurrencyTableViewCell"
    
    //MARK: - GUI variables
    
    private lazy var currencyImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(named: "rub")
        imageView.layer.cornerRadius = 24
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var currencyLabel: UILabel = {
        var label = UILabel()
        label.text = "RUB (Российский рубль)"
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = Colors.textBlackHight.color()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
    
    func initCell(title: String) {
        self.currencyLabel.text = title
        let fullPath = Network.shared.baseImageURL + "flags-\(String(title.prefix(3))).png"
        guard let imageURL = URL(string: fullPath) else { return }
        self.currencyImageView.kf.setImage(with: imageURL)
        self.setNeedsUpdateConstraints()
    }
    
    //MARK: - Constraints
    
    override func updateConstraints() {
        self.currencyImageView.snp.updateConstraints { (make) in
            make.top.bottom.equalToSuperview().inset(8)
            make.left.equalToSuperview()
            make.size.equalTo(48)
        }
        self.currencyLabel.snp.updateConstraints { (make) in
            make.left.equalTo(self.currencyImageView.snp.right).offset(20)
            make.right.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
        }
        
        super.updateConstraints()
    }
    
    //MARK: - Setters
    
    private func addSubviews() {
        self.contentView.addSubview(self.currencyImageView)
        self.contentView.addSubview(self.currencyLabel)
    }
    
}
