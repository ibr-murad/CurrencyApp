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
    private var gradientColors: [UIColor] = []
    
    //MARK: - GUI variables
    
    private lazy var containerView: UIView = {
        var view = UIView()
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        view.tag = 11
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var logoImageView: UIImageView = {
        var imageView = UIImageView()
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
        label.text = "Самый выгодный курс по переводам"
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .center
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
        view.setColor([UIColor.white.withAlphaComponent(0.8), .white])
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
    
    //MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.addSubviews()
    }
    
    convenience init(color: UIColor) {
        self.init(frame: .zero)
        
        self.gradientColors = [color, color.withAlphaComponent(50)]
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if !self.isContainerHaveBackground {
            self.setupContainerViewBackground()
        }
    }
    
    //MARK: - Constraints
    
    override func updateConstraints() {
        self.containerView.snp.updateConstraints { (make) in
            make.edges.equalToSuperview().inset(16)
        }
        self.logoImageView.snp.updateConstraints { (make) in
            make.top.left.equalToSuperview().inset(20)
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
            make.centerX.equalToSuperview()
        }
        self.lineView3.snp.updateConstraints { (make) in
            make.top.equalTo(self.currencyView.snp.bottom).offset(20)
            make.left.right.equalToSuperview()
            make.height.equalTo(1)
        }
        self.convertButton.snp.updateConstraints { (make) in
            make.top.equalTo(self.lineView3.snp.bottom).offset(30)
            make.left.right.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(30)
            make.height.equalTo(40)
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
        
        self.setNeedsUpdateConstraints()
    }
    
    private func setupContainerViewBackground() {
        let gradientRect = self.containerView.bounds
        let gradienColors: [UIColor] = [.init(rgb: 0xDE5000, alpha: 1), .init(rgb: 0xFC8D26, alpha: 1)]
        self.containerView.setGradient(rect: gradientRect, colors: gradienColors)
        self.containerView.dropShadow(
            color: .init(rgb: 0xFB8B25, alpha: 0.52),
            opacity: 1, offSet: .init(width: 0, height: 8), radius: 20)
        self.isContainerHaveBackground = true
    }
    
    func setColor(gradient colors: [UIColor], shadow color: UIColor) {
        if let gradientLayer = self.containerView.layer.sublayers?[0] as? CAGradientLayer {
            gradientLayer.colors = colors
        }
    }
    
}
