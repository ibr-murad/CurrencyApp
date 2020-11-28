//
//  HeaderDetailTopView.swift
//  CurrencyApp
//
//  Created by Humo Programmer on 10/13/20.
//

import UIKit

class DetailTopView: UIView {
    
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
    
    private lazy var currencyView: ExtendedCurrencyView = {
        var view = ExtendedCurrencyView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var convertButton: UIButton = {
        var button = UIButton(type: .custom)
        button.setTitle("Ковертировать по этому курсу", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
        button.backgroundColor = .init(rgb: 0xFFFFFF, alpha: 0.20)
        button.layer.cornerRadius = 24
        button.clipsToBounds = true
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
    
    func initView(_ model: BankRatesModel) {
        self.currencyView.initView(model.currency)
        self.setNeedsUpdateConstraints()
    }
    
    //MARK: - Constraints
    
    override func updateConstraints() {
        self.containerView.snp.remakeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        self.lineView1.snp.remakeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(1)
        }
        self.titleLabel.snp.remakeConstraints { (make) in
            make.top.equalTo(self.lineView1.snp.bottom).offset(16)
            make.left.right.equalToSuperview().inset(20)
        }
        self.lineView2.snp.remakeConstraints { (make) in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(16)
            make.left.right.equalToSuperview()
            make.height.equalTo(1)
        }
        self.currencyView.snp.remakeConstraints { (make) in
            make.top.equalTo(self.lineView2.snp.bottom).offset(20)
            make.left.right.equalToSuperview()
        }
        self.convertButton.snp.remakeConstraints { (make) in
            make.top.equalTo(self.currencyView.snp.bottom).offset(30)
            make.left.right.bottom.equalToSuperview().inset(30)
            make.height.equalTo(48)
        }
        
        super.updateConstraints()
    }
    
    //MARK: - Setters
    
    private func addSubviews() {
        self.addSubview(self.containerView)
        self.containerView.addSubview(self.lineView1)
        self.containerView.addSubview(self.titleLabel)
        self.containerView.addSubview(self.lineView2)
        self.containerView.addSubview(self.currencyView)
        self.containerView.addSubview(self.convertButton)
        
        self.setNeedsUpdateConstraints()
    }
    
}

