//
//  HeaderDetailTopView.swift
//  CurrencyApp
//
//  Created by Humo Programmer  on 10/13/20.
//

import UIKit

class HeaderDetailTopView: UIView {
    
    //MARK: - Public variables
    
    var isOpenState: Bool = false {
        willSet {
            self.setNeedsUpdateConstraints()
        }
    }
    
    //MARK: - Private variables
    
    private var isContainerHaveBackground = false
    
    //MARK: - GUI variables
    
    private lazy var containerView: UIView = {
        var view = UIView()
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
    
    private lazy var currencyView1: CurrencyView = {
        var view = CurrencyView()
        view.setColor([UIColor.white.withAlphaComponent(0.8), .white])
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var currencyView2: CurrencyView = {
        var view = CurrencyView()
        view.setColor([UIColor.white.withAlphaComponent(0.8), .white])
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var currencyView3: CurrencyView = {
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
    
    //MARK: - Constraints
    
    override func updateConstraints() {
        if self.isOpenState {
            self.openStateConstraints()
        } else {
            self.closeStateConstraints()
        }
        
        super.updateConstraints()
    }
    
    private func closeStateConstraints() {
        self.containerView.snp.remakeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        self.lineView1.snp.remakeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(1)
        }
        self.titleLabel.snp.remakeConstraints { (make) in
            make.top.equalTo(self.lineView1.snp.bottom).offset(8)
            make.left.right.equalToSuperview().inset(20)
        }
        self.lineView2.snp.remakeConstraints { (make) in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(8)
            make.left.right.equalToSuperview()
            make.height.equalTo(1)
        }
        self.currencyView1.snp.remakeConstraints { (make) in
            make.top.equalTo(self.lineView2.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        self.currencyView2.snp.remakeConstraints { (make) in
            make.top.equalTo(self.lineView2.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        self.currencyView3.snp.remakeConstraints { (make) in
            make.top.equalTo(self.lineView2.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        self.lineView3.snp.remakeConstraints { (make) in
            make.top.equalTo(self.currencyView1.snp.bottom).offset(20)
            make.left.right.equalToSuperview()
            make.height.equalTo(1)
        }
        self.lineView3.snp.remakeConstraints { (make) in
            make.top.equalTo(self.currencyView1.snp.bottom).offset(20)
            make.left.right.equalToSuperview()
            make.height.equalTo(1)
        }
        self.convertButton.snp.remakeConstraints { (make) in
            make.top.equalTo(self.lineView3.snp.bottom).offset(30)
            make.left.right.bottom.equalToSuperview().inset(30)
            make.height.equalTo(40)
        }
        UIView.animate(withDuration: 0.5) {
            self.currencyView2.alpha = 0
            self.currencyView3.alpha = 0
        }
    }
    
    private func openStateConstraints() {
        self.containerView.snp.remakeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        self.lineView1.snp.remakeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(1)
        }
        self.titleLabel.snp.remakeConstraints { (make) in
            make.top.equalTo(self.lineView1.snp.bottom).offset(8)
            make.left.right.equalToSuperview().inset(20)
        }
        self.lineView2.snp.remakeConstraints { (make) in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(8)
            make.left.right.equalToSuperview()
            make.height.equalTo(1)
        }
        self.currencyView1.snp.remakeConstraints { (make) in
            make.top.equalTo(self.lineView2.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        self.currencyView2.snp.remakeConstraints { (make) in
            make.top.equalTo(self.currencyView1.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        self.currencyView3.snp.remakeConstraints { (make) in
            make.top.equalTo(self.currencyView2.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        self.lineView3.snp.remakeConstraints { (make) in
            make.top.equalTo(self.currencyView3.snp.bottom).offset(20)
            make.left.right.equalToSuperview()
            make.height.equalTo(1)
        }
        self.convertButton.snp.remakeConstraints { (make) in
            make.top.equalTo(self.lineView3.snp.bottom).offset(30)
            make.left.right.bottom.equalToSuperview().inset(30)
            make.height.equalTo(40)
        }
        UIView.animate(withDuration: 0.5) {
            self.currencyView2.alpha = 1
            self.currencyView3.alpha = 1
        }
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
        self.containerView.addSubview(self.lineView1)
        self.containerView.addSubview(self.titleLabel)
        self.containerView.addSubview(self.lineView2)
        self.containerView.addSubview(self.currencyView1)
        self.containerView.addSubview(self.currencyView2)
        self.containerView.addSubview(self.currencyView3)
        self.containerView.addSubview(self.lineView3)
        self.containerView.addSubview(self.convertButton)
        
        self.setNeedsUpdateConstraints()
    }
    
    private func setupContainerViewBackground() {
        let gradientRect = self.containerView.bounds
        let gradienColors: [UIColor] = [.init(rgb: 0xDE5000, alpha: 1), .init(rgb: 0xFC8D26, alpha: 1)]
        self.containerView.setGradient(rect: gradientRect, colors: gradienColors)
        self.isContainerHaveBackground = true
    }
    
}

