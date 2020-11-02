//
//  MainTopView.swift
//  CurrencyApp
//
//  Created by Humo Programmer  on 10/7/20.
//

import UIKit
import SnapKit

class MainHeaderView: UIView {
    
    //MARK: - Private variables
    
    private var isContainerHaveBackground = false
    
    //MARK: - GUI variables
    
    private lazy var containerView: UIView = {
        var view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        view.tag = 11
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var logoImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.isWindlessable = true
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "humoWhite")
        imageView.tag = 22
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var shareButton: UIButton = {
        var button = UIButton(type: .system)
        button.setImage(UIImage(named: "share"), for: .normal)
        button.tintColor = .white
        button.tag = 33
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var lineView1: UIView = {
        var view = UIView()
        view.backgroundColor = .init(rgb: 0xFFFFFF, alpha: 0.12)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var titleLabel: UILabel = {
        var label = UILabel()
        label.isWindlessable = true
        label.text = "Самый выгодный курс по переводам"
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var lineView2: UIView = {
        var view = UIView()
        view.backgroundColor = .init(rgb: 0xFFFFFF, alpha: 0.12)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var currencyView: CurrencyView = {
        var view = CurrencyView()
        view.isWindlessable = true
        view.setColor([UIColor.white.withAlphaComponent(0.8), .white])
        view.setFont(.systemFont(ofSize: 20, weight: .bold))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var lineView3: UIView = {
        var view = UIView()
        view.backgroundColor = .init(rgb: 0xFFFFFF, alpha: 0.12)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var convertButton: UIButton = {
        var button = UIButton(type: .custom)
        button.isWindlessable = true
        button.setTitle("Ковертировать по этому курсу", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
        button.backgroundColor = .init(rgb: 0xFFFFFF, alpha: 0.20)
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(self.convertButtonTapped(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var name: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
    
    func initView(viewModel: BankRatesViewModel) {
        for i in 0..<viewModel.currency.count {
            if viewModel.currency[i].name == Settings.shared.currentCurrencyName {
                self.currencyView.initView(model: viewModel.currency[i])
                break
            }
        }
        //self.name.text = viewModel.name
        
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
        self.logoImageView.snp.updateConstraints { (make) in
            make.top.left.equalToSuperview().inset(20)
            make.width.greaterThanOrEqualTo(50)
        }
        self.shareButton.snp.updateConstraints { (make) in
            make.right.equalToSuperview().inset(20)
            make.centerY.equalTo(self.logoImageView.snp.centerY)
            make.size.equalTo(CGSize(width: 20, height: 26))
        }
        self.lineView1.snp.updateConstraints { (make) in
            make.top.equalTo(self.logoImageView.snp.bottom).offset(20)
            make.left.right.equalToSuperview()
            make.height.equalTo(1)
        }
        self.titleLabel.snp.updateConstraints { (make) in
            make.top.equalTo(self.lineView1.snp.bottom).offset(8)
            make.left.right.equalToSuperview().inset(20)
        }
        self.lineView2.snp.updateConstraints { (make) in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(8)
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
            make.height.equalTo(40)
        }
        self.name.snp.updateConstraints { (make) in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        super.updateConstraints()
    }
    
    //MARK: - Actions
    
    @objc private func convertButtonTapped(_ sender: UIButton) {
        sender.tapAnimation {
            NotificationCenter.default.post(name: .headerConvertButtonTapped, object: nil)
        }
    }
    
    //MARK: - Setters
    
    private func addSubviews() {
        self.addSubview(self.containerView)
        self.containerView.addSubview(self.logoImageView)
        self.containerView.addSubview(self.shareButton)
        self.containerView.addSubview(self.lineView1)
        self.containerView.addSubview(self.titleLabel)
        self.containerView.addSubview(self.lineView2)
        self.containerView.addSubview(self.currencyView)
        self.containerView.addSubview(self.lineView3)
        self.containerView.addSubview(self.convertButton)
        self.containerView.addSubview(self.name)
        
        self.setNeedsUpdateConstraints()
    }
    
    func updateGradientAndShadowColor() {
        let model = UserDefaults.standard.getCurrentTopColorModel()
        let gradientRect = self.containerView.bounds
        var gradientColors: [UIColor] = []
        for color in model.gradientColors {
            gradientColors.append(UIColor(rgb: color, alpha: 1.0))
        }
        let shadowColor = UIColor(rgb: model.shadowColor, alpha: 1.0)
        self.containerView.setGradient(rect: gradientRect, colors: gradientColors)
        self.containerView.dropShadow(
            color: shadowColor,opacity: 0.6, offSet: .init(width: 0, height: 8), radius: 10)
        self.isContainerHaveBackground = true
    }
    
}
