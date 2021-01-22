//
//  ConvertView.swift
//  CurrencyApp
//
//  Created by Murodjon Ibrohimov on 11/5/20.
//

import UIKit

class ConvertView: UIView {
    
    //MARK: - Public variables
    
    var culculateHandler: (() -> Void)?
    var changeHandler: (() -> Void)?
    
    //MARK: - GUI variables
    
    //MARK: Top view
    
    private lazy var topView: UIView = {
        var view = UIView()
        view.backgroundColor = .init(rgb: 0xFFFFFF, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var topCurrencyView: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var topCurrencyLabel: UILabel = {
        var label = UILabel()
        label.numberOfLines = 1
        label.textColor = .black
        label.font = .systemFont(ofSize: 32, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var topDropIconImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(named: "dropDown")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    lazy var topValueTextField: UITextField = {
        var field = UITextField()
        field.delegate = self
        field.text = "0"
        field.keyboardType = .decimalPad
        field.becomeFirstResponder()
        field.textColor = .black
        field.textAlignment = .right
        field.inputAccessoryView = self.keyboardToolBar
        field.font = .systemFont(ofSize: 32, weight: .regular)
        field.addTarget(self, action: #selector(self.textFieldValueChanged), for: .editingChanged)
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    lazy var keyboardToolBar: UIToolbar = {
        var bar = UIToolbar()
        var doneButton = UIBarButtonItem(
            title: "Готово", style: .done, target: self,
            action: #selector(self.keyboardDoneButtonTapped))
        var flexibleSpaceButton = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        bar.setItems([flexibleSpaceButton, doneButton], animated: false)
        bar.barStyle = .default
        bar.isTranslucent = true
        bar.tintColor = .blue
        bar.sizeToFit()
        bar.isUserInteractionEnabled = true
        bar.translatesAutoresizingMaskIntoConstraints = false
        return bar
    }()
    
    //MARK: Center view
    
    private lazy var centerView: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var centerChangeButtonBackgroundView: UIView = {
        var view = UIView()
        view.layer.cornerRadius = 18
        view.backgroundColor = UIColor.black.withAlphaComponent(0.15)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var centerChangeButton: UIButton = {
        var button = UIButton(type: .system)
        button.layer.cornerRadius = 18
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.init(rgb: 0xF3F4F5, alpha: 1).cgColor
        button.backgroundColor = .white
        button.tintColor = .init(rgb: 0x208FB7)
        button.setImage(UIImage(named: "change"), for: .normal)
        button.adjustsImageWhenHighlighted = false
        button.addTarget(self, action: #selector(self.changeButtonTapped(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var centerValueView: UIView = {
        var view = UIView()
        view.layer.cornerRadius = 18
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.init(rgb: 0xF3F4F5, alpha: 1).cgColor
        view.backgroundColor = .init(rgb: 0xFFFFFF, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var centerValueLabel: UILabel = {
        var label = UILabel()
        label.text = "1 RUB = 0.1350 TJS"
        label.numberOfLines = 1
        label.textColor = .init(rgb: 0x208FB7)
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var centerChartImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(named: "chart")?
            .with(color: .init(rgb: 0x208FB7))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    //MARK: Bottom view

    private lazy var bottomView: UIView = {
        var view = UIView()
        view.backgroundColor = .init(rgb: 0xF3F4F5, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var bottomCurrencyView: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var bottomCurrencyLabel: UILabel = {
        var label = UILabel()
        label.text = "TJS"
        label.numberOfLines = 1
        label.textColor = .black
        label.font = .systemFont(ofSize: 32, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var bottomDropIconImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(named: "dropDown")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    lazy var bottomValueLabel: UILabel = {
        var label = UILabel()
        label.text = "0"
        label.numberOfLines = 1
        label.textAlignment = .right
        label.textColor = .black
        label.font = .systemFont(ofSize: 32, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var descriptionView: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var descriptionLabel: UILabel = {
        var label = UILabel()
        label.text = "Последний раз обновлено " + UserDefaults.standard.lastUpdated
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var downloadButton: UIButton = {
        var button = UIButton()
        button.clipsToBounds = true
        button.adjustsImageWhenHighlighted = false
        button.setTitle("Скачать приложение банка", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setImage(UIImage(named: "share"), for: .normal)
        button.imageEdgeInsets.right = 20
        if #available(iOS 13.0, *) {
            button.layer.cornerCurve = .continuous
        }
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 16
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
        
        self.topView.snp.updateConstraints { (make) in
            make.top.left.right.equalToSuperview()
        }
        self.topCurrencyView.snp.updateConstraints { (make) in
            make.top.bottom.equalToSuperview().inset(60)
            make.left.equalToSuperview().inset(20)
        }
        self.topCurrencyLabel.snp.updateConstraints { (make) in
            make.top.left.bottom.equalToSuperview()
        }
        self.topDropIconImageView.snp.updateConstraints { (make) in
            make.left.equalTo(self.topCurrencyLabel.snp.right).offset(16)
            make.right.equalToSuperview()
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 12, height: 8))
        }
        self.topValueTextField.snp.updateConstraints { (make) in
            make.top.bottom.equalToSuperview().inset(60)
            make.right.equalToSuperview().inset(20)
        }
        
        self.centerView.snp.updateConstraints { (make) in
            make.top.equalTo(self.topView.snp.bottom).inset(18)
            make.left.right.equalToSuperview()
        }
        self.centerChangeButtonBackgroundView.snp.updateConstraints { (make) in
            make.center.equalTo(self.centerChangeButton)
            make.size.equalTo(self.centerChangeButton)
        }
        self.centerChangeButton.snp.updateConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().inset(20)
            make.size.equalTo(36)
        }
        self.centerValueView.snp.updateConstraints { (make) in
            make.centerX.equalToSuperview()
            make.height.equalTo(36)
        }
        self.centerChartImageView.snp.updateConstraints { (make) in
            make.top.left.bottom.equalToSuperview().inset(13)
            make.size.equalTo(CGSize(width: 17, height: 10))
        }
        self.centerValueLabel.snp.updateConstraints { (make) in
            make.left.equalTo(self.centerChartImageView.snp.right).offset(10)
            make.right.equalToSuperview().inset(13)
            make.centerY.equalToSuperview()
        }
        
        self.bottomView.snp.updateConstraints { (make) in
            make.top.equalTo(self.topView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
        self.bottomCurrencyView.snp.updateConstraints { (make) in
            make.top.equalToSuperview().inset(60)
            make.left.equalToSuperview().inset(20)
        }
        self.bottomCurrencyLabel.snp.updateConstraints { (make) in
            make.top.left.bottom.equalToSuperview()
        }
        self.bottomDropIconImageView.snp.updateConstraints { (make) in
            make.left.equalTo(self.bottomCurrencyLabel.snp.right).offset(16)
            make.right.equalToSuperview()
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 12, height: 8))
        }
        self.bottomValueLabel.snp.updateConstraints { (make) in
            make.top.equalToSuperview().inset(60)
            make.right.equalToSuperview().inset(20)
        }
        self.descriptionView.snp.updateConstraints { (make) in
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().inset(80)
        }
        self.descriptionLabel.snp.updateConstraints { (make) in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        self.downloadButton.snp.updateConstraints { (make) in
            make.top.equalTo(self.descriptionLabel.snp.bottom).offset(8)
            make.left.right.equalToSuperview().inset(36)
            make.bottom.equalToSuperview()
            make.height.equalTo(48)
        }
        super.updateConstraints()
    }
    
    //MARK: - Setters
    
    private func addSubviews() {
        self.insertSubview(self.topView, at: 0)
        self.topView.addSubview(self.topCurrencyView)
        self.topView.addSubview(self.topValueTextField)
        self.topCurrencyView.addSubview(self.topCurrencyLabel)
        self.topCurrencyView.addSubview(self.topDropIconImageView)
        
        self.insertSubview(self.centerView, at: 2)
        self.centerView.addSubview(self.centerChangeButtonBackgroundView)
        self.centerView.addSubview(self.centerChangeButton)
        self.centerView.addSubview(self.centerValueView)
        self.centerValueView.addSubview(self.centerChartImageView)
        self.centerValueView.addSubview(self.centerValueLabel)
        
        self.insertSubview(self.bottomView, at: 1)
        self.bottomView.addSubview(self.bottomCurrencyView)
        self.bottomView.addSubview(self.bottomValueLabel)
        self.bottomCurrencyView.addSubview(self.bottomCurrencyLabel)
        self.bottomCurrencyView.addSubview(self.bottomDropIconImageView)
        
        self.addSubview(self.descriptionView)
        self.descriptionView.addSubview(self.descriptionLabel)
        self.descriptionView.addSubview(self.downloadButton)
    }
    
    //MARK: - Actions
    
    @objc private func changeButtonTapped(_ sender: UIButton) {
        self.animateViewsOnChangeButtomTapped()
    }
    
    @objc private func keyboardDoneButtonTapped() {
        self.endEditing(true)
    }
    
    //MARK: - Animations
    
    private func animateViewsOnChangeButtomTapped() {
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.centerChangeButtonBackgroundView.transform = CGAffineTransform(scaleX: 1.25, y: 1.25)
            self?.centerChangeButton.transform = CGAffineTransform(rotationAngle: .pi)
        } completion: { [weak self] (done) in
            self?.centerChangeButtonBackgroundView.transform = CGAffineTransform.identity
            self?.centerChangeButton.transform = CGAffineTransform.identity
        }
        UIView.animate(withDuration: 0.2) { [weak self] in
            guard let weakSelf = self else { return }
            let topViewFinalY: CGFloat = 60
            let bottomViewFinalY: CGFloat = -60
            
            weakSelf.topCurrencyView.transform = CGAffineTransform(translationX: 0, y: topViewFinalY)
            weakSelf.bottomCurrencyView.transform = CGAffineTransform(translationX: 0, y: bottomViewFinalY)
        } completion: { [weak self] (done) in
            guard let weakSelf = self else { return }
            UIView.animate(withDuration: 0.15) {
                weakSelf.topCurrencyView.transform = CGAffineTransform.identity
                weakSelf.bottomCurrencyView.transform = CGAffineTransform.identity
                weakSelf.changeHandler?()
            }
        }
    }
    
}

//MARK: - UITextFieldDelegate

extension ConvertView: UITextFieldDelegate {
    
    @objc private func textFieldValueChanged(_ sender: UITextField) {
        self.culculateHandler?()
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField.text?.isEmpty == true {
            textField.text = "0"
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.text?.isEmpty == true && string.isEmpty {
            textField.text = "0"
            return false
        } else if textField.text == "0" {
            textField.text = string
            self.culculateHandler?()
            return false
        }
        return true
    }
    
}
