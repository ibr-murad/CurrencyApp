//
//  MainTopView.swift
//  CurrencyApp
//
//  Created by Murodjon Ibrohimovon 10/7/20.
//

import UIKit
import SnapKit
import Kingfisher

class MainHeaderView: UIView {
    
    var currencyName: String {
        if self.type == .type1 {
            return Settings.shared.defaultCurrency.rawValue
        }
        return DefaultCurrency.rub.rawValue
    }
    var type: MainDataType = .type1
    
    //MARK: - Private variables
    
    private var isContainerHaveBackground = false
    
    //MARK: - GUI variables
    
    private lazy var containerView: UIView = {
        var view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var logoConteinerView: UIView = {
        var view = UIView()
        view.isWindlessable = true
        view.clipsToBounds = false
        view.layer.cornerRadius = 6
        return view
    }()
    
    private lazy var logoImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        //imageView.backgroundColor = .white
        return imageView
    }()
    
    private lazy var logoNameLabel: UILabel = {
        var label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var shareButton: UIButton = {
        var button = UIButton(type: .system)
        button.setImage(UIImage(named: "share"), for: .normal)
        button.tintColor = .white
        button.tag = 33
        return button
    }()

    private lazy var lineView1: UIView = {
        var view = UIView()
        view.backgroundColor = .init(rgb: 0xFFFFFF, alpha: 0.12)
        return view
    }()
    
    private lazy var titleLableContainerView: UIView = {
        var view = UIView()
        view.isWindlessable = true
        view.clipsToBounds = false
        view.layer.cornerRadius = 6
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        var label = UILabel()
        label.text = "Самый выгодный курс по переводам"
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var lineView2: UIView = {
        var view = UIView()
        view.backgroundColor = .init(rgb: 0xFFFFFF, alpha: 0.12)
        return view
    }()
    
    private lazy var currencyView: CurrencyView = {
        var view = CurrencyView()
        view.isWindlessable = true
        view.clipsToBounds = false
        view.layer.cornerRadius = 12
        view.setColor([UIColor.white.withAlphaComponent(0.8), .white])
        view.setFont(.systemFont(ofSize: 20, weight: .bold))
        return view
    }()
    
    private lazy var lineView3: UIView = {
        var view = UIView()
        view.backgroundColor = .init(rgb: 0xFFFFFF, alpha: 0.12)
        return view
    }()
    
    lazy var convertButton: UIButton = {
        var button = UIButton(type: .custom)
        button.isWindlessable = true
        button.setTitle("Ковертировать по этому курсу", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
        button.backgroundColor = .init(rgb: 0xFFFFFF, alpha: 0.20)
        button.layer.cornerRadius = 24
        button.clipsToBounds = true
        return button
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
    
    func initView(model: BankRatesModel) {
        for i in 0..<model.currency.count {
            if model.currency[i].name == self.currencyName {
                self.currencyView.initView(model: model.currency[i])
                break
            }
        }
        self.logoNameLabel.text = model.name
        self.updateGradientAndShadowColor(model.colors)
        
        model.getImage { (image) in            
            self.logoImageView.image = image
        }
        self.setNeedsUpdateConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if !self.isContainerHaveBackground {
            self.updateGradientAndShadowColor()
        }
    }
    
    //MARK: - Constraints
    
    override func updateConstraints() {
        self.containerView.snp.updateConstraints { (make) in
            make.edges.equalToSuperview().inset(16)
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
        self.shareButton.snp.updateConstraints { (make) in
            make.right.equalToSuperview().inset(20)
            make.left.greaterThanOrEqualTo(self.logoConteinerView.snp.right).offset(16)
            make.centerY.equalTo(self.logoImageView.snp.centerY)
            make.size.equalTo(CGSize(width: 20, height: 26))
        }
        self.lineView1.snp.updateConstraints { (make) in
            make.top.equalTo(self.logoImageView.snp.bottom).offset(20)
            make.left.right.equalToSuperview()
            make.height.equalTo(1)
        }
        self.titleLableContainerView.snp.updateConstraints { (make) in
            make.top.equalTo(self.lineView1.snp.bottom).offset(8)
            make.left.right.equalToSuperview().inset(20)
        }
        self.titleLabel.snp.updateConstraints { (make) in
            make.edges.equalToSuperview()
        }
        self.lineView2.snp.updateConstraints { (make) in
            make.top.equalTo(self.titleLableContainerView.snp.bottom).offset(8)
            make.left.right.equalToSuperview()
            make.height.equalTo(1)
        }
        self.currencyView.snp.updateConstraints { (make) in
            make.top.equalTo(self.lineView2.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(20)
        }
        self.lineView3.snp.updateConstraints { (make) in
            make.top.equalTo(self.currencyView.snp.bottom).offset(20)
            make.left.right.equalToSuperview()
            make.height.equalTo(1)
        }
        self.convertButton.snp.updateConstraints { (make) in
            make.top.equalTo(self.lineView3.snp.bottom).offset(20)
            make.left.right.bottom.equalToSuperview().inset(20)
            make.height.equalTo(48)
        }
        super.updateConstraints()
    }
    
    //MARK: - Setters
    
    private func addSubviews() {
        self.addSubview(self.containerView)
        self.containerView.addSubview(self.logoConteinerView)
        self.logoConteinerView.addSubview(self.logoImageView)
        self.logoConteinerView.addSubview(self.logoNameLabel)
        self.containerView.addSubview(self.shareButton)
        self.containerView.addSubview(self.lineView1)
        self.containerView.addSubview(self.titleLableContainerView)
        self.titleLableContainerView.addSubview(self.titleLabel)
        self.containerView.addSubview(self.lineView2)
        self.containerView.addSubview(self.currencyView)
        self.containerView.addSubview(self.lineView3)
        self.containerView.addSubview(self.convertButton)
        
        self.setNeedsUpdateConstraints()
    }
    
    func updateGradientAndShadowColor(_ colorsModel: ColorsModel? = nil) {
        var gradientColors: [UIColor] = [.init(rgb: 0x000000), .init(rgb: 0x000000)]
        var shadowColor: UIColor = .init(rgb: 0x000000)
        let gradientRect = self.containerView.bounds
        if let colorsModel = colorsModel {
            gradientColors = [.init(hex: colorsModel.color_1), .init(hex: colorsModel.color_2)]
            shadowColor = .init(hex: colorsModel.color_1)
        }
        self.containerView.setGradient(rect: gradientRect, colors: gradientColors)
        self.containerView.dropShadow(
            color: shadowColor,opacity: 0.6, offSet: .init(width: 0, height: 8), radius: 10)
        self.isContainerHaveBackground = true
    }
    
}
