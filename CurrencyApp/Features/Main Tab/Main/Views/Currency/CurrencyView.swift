//
//  CurrencyView.swift
//  CurrencyApp
//
//  Created by Murodjon Ibrohimovon 10/8/20.
//

import UIKit

class CurrencyView: UIView {
    
    //MARK: - GUI variables
    
    //MARK: Plain mode
    
    private lazy var firstLabel:  UILabel = {
        var label = UILabel()
        label.text = "----"
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = Colors.textBlackHight.color()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var secondLabel: UILabel = {
        var label = UILabel()
        label.text = "----"
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = Colors.textBlackHight.color()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: Extented mode
    
    private lazy var firstItem: CurrencyItemView = {
        var view = CurrencyItemView()
        view.initView("Валюта", "---")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var secondItem: CurrencyItemView = {
        var view = CurrencyItemView()
        view.initView("Покупка", "---")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var thirdItem: CurrencyItemView = {
        var view = CurrencyItemView()
        view.initView("Продажа", "---")
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
        self.modeUpdated()
        
        NotificationCenter.default.addObserver(
            self, selector: #selector(self.modeUpdated),
            name: .modeUpdated, object: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.addSubviews()
    }
    
    func initView(model: CurrencyModel) {
        self.firstItem.initView("Валюта", "1 " + model.name)
        self.secondItem.initView("Покупка", model.buy)
        self.thirdItem.initView("Продажа", model.sell)
        
        self.firstLabel.text = "1 " + model.name
        self.secondLabel.text = model.buy + " TJS"
        
        self.setNeedsUpdateConstraints()
    }
    
    //MARK: - Constraints
    
    override func updateConstraints() {
        self.firstLabel.snp.updateConstraints { (make) in
            make.left.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        self.secondLabel.snp.updateConstraints { (make) in
            make.left.greaterThanOrEqualTo(self.firstLabel.snp.right).offset(10)
            make.centerY.equalToSuperview()
        }
        
        self.firstItem.snp.updateConstraints { (make) in
            make.top.left.bottom.equalToSuperview()
        }
        self.secondItem.snp.updateConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.width.equalTo(80).priority(700)
        }
        self.thirdItem.snp.updateConstraints { (make) in
            make.top.right.bottom.equalToSuperview()
            make.left.equalTo(self.secondItem.snp.right).offset(24)
            make.width.equalTo(80).priority(700)
        }
        
        self.arrorwImageContainerView.snp.remakeConstraints { (make) in
            if Settings.shared.mode == .plain {
                make.left.equalTo(self.firstLabel.snp.right).offset(40)
                make.right.equalTo(self.secondLabel.snp.left).offset(-40)
                make.centerY.equalTo(self.firstLabel.snp.centerY)
            } else {
                make.left.equalTo(self.firstItem.snp.right)
                make.right.equalTo(self.secondItem.snp.left)
                make.bottom.equalToSuperview()
            }
        }
        self.arrorwImageView.snp.remakeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 28, height: 22))
        }

        super.updateConstraints()
    }
    
    //MARK: - Setters
    
    private func addSubviews() {
        self.addSubview(self.firstLabel)
        self.addSubview(self.secondLabel)
        
        self.addSubview(self.firstItem)
        self.addSubview(self.secondItem)
        self.addSubview(self.thirdItem)
        
        self.addSubview(self.arrorwImageContainerView)
        self.arrorwImageContainerView.addSubview(self.arrorwImageView)
    }
    
    func setColor(_ colors: [UIColor]) {
        self.firstLabel.textColor = colors[1]
        self.secondLabel.textColor = colors[1]
        self.firstItem.setColor(colors)
        self.secondItem.setColor(colors)
        self.thirdItem.setColor(colors)
        let coloredImage = self.arrorwImageView.image?.with(color: colors[1])
        self.arrorwImageView.image = coloredImage
    }
    
    func setFont(_ font: UIFont) {
        self.firstItem.setFont(font)
        self.secondItem.setFont(font)
        self.thirdItem.setFont(font)
    }
    
    //MARK: - Helpers
    
    @objc private func modeUpdated() {
        if Settings.shared.mode == .plain {
            self.firstLabel.isHidden = false
            self.secondLabel.isHidden = false
            self.firstItem.isHidden = true
            self.secondItem.isHidden = true
            self.thirdItem.isHidden = true
        } else {
            self.firstLabel.isHidden = true
            self.secondLabel.isHidden = true
            self.firstItem.isHidden = false
            self.secondItem.isHidden = false
            self.thirdItem.isHidden = false
        }
        self.setNeedsUpdateConstraints()
    }
    
}
