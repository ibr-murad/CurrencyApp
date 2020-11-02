//
//  ConvertViewController.swift
//  CurrencyApp
//
//  Created by Humo Programmer  on 10/8/20.
//

import UIKit

class ConvertViewController: UIViewController {
    
    //MARK: - Public variables
    
    var closeButtonTappedHandler: (() -> Void)?
    
    //MARK: - Private variables
    
    private var fromCurrency = "RUB"
    private var toCurrency = "TJS"
    private let currentMultilier: Float = 0.1350
    
    //MARK: - GUI variables
    
    //MARK: Top view
    
    private lazy var topView: UIView = {
        var view = UIView()
        view.backgroundColor = .init(rgb: 0xFFFFFF, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var topCurrencyView: UIView = {
        var view = UIView()
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.topViewTapped))
        view.addGestureRecognizer(tap)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var topCurrencyLabel: UILabel = {
        var label = UILabel()
        label.text = self.fromCurrency
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

    private lazy var topValueTextField: UITextField = {
        var field = UITextField()
        //field.borderStyle = .roundedRect
        field.keyboardType = .numberPad
        field.becomeFirstResponder()
        field.textColor = .black
        field.textAlignment = .right
        field.inputAccessoryView = self.keyboardToolBar
        field.font = .systemFont(ofSize: 32, weight: .regular)
        field.addTarget(self, action: #selector(self.topTextFieldValueChanged), for: .editingChanged)
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    //MARK: Center view
    
    private lazy var centerView: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var centerChangeButton: UIButton = {
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

    private lazy var centerValueLabel: UILabel = {
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
    
    private lazy var centerChartImageView: UIImageView = {
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
    
    private lazy var bottomCurrencyView: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var bottomCurrencyLabel: UILabel = {
        var label = UILabel()
        label.text = self.toCurrency
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

    private lazy var bottomValueLabel: UILabel = {
        var label = UILabel()
        label.text = "0"
        label.numberOfLines = 1
        label.textAlignment = .right
        label.textColor = .black
        label.font = .systemFont(ofSize: 32, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var footerFloatButton: UIButton = {
        var button = UIButton()
        button.clipsToBounds = true
        button.setTitle("Скачать Хумо Переводы", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
        button.addTarget(self, action: #selector(self.footerFloatButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 24
        let gradientRect = CGRect(x: 0, y: 0, width: self.view.bounds.width - 36 - 36, height: 48)
        let gradienColors: [UIColor] = [.init(rgb: 0xDE5000, alpha: 1), .init(rgb: 0xFC8D26, alpha: 1)]
        button.setGradient(rect: gradientRect, colors: gradienColors)
        return button
    }()

    private lazy var keyboardToolBar: UIToolbar = {
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
    
    private lazy var closeBarButton: UIBarButtonItem = {
        var button = UIBarButtonItem(
            image: UIImage(named: "close"),
            style: .plain, target: self, action: #selector(self.closeBarButtonTapped(_:)))
        button.tintColor = .black
        return button
    }()

    private lazy var shareBarButton: UIBarButtonItem = {
        var button = UIBarButtonItem(
            barButtonSystemItem: .action,
            target: self, action: #selector(shareBarButtonTapped(_:)))
        return button
    }()
    
    //MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.hideKeyboardWhenTappedAround()
        self.setupNavigationBar()
        self.addSubviews()
        self.makeConstraints()
    }
    
    //MARK: - Constraints
    
    private func makeConstraints() {
        self.topView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
        }
        self.topCurrencyView.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview().inset(60)
            make.left.equalToSuperview().inset(20)
        }
        self.topCurrencyLabel.snp.makeConstraints { (make) in
            make.top.left.bottom.equalToSuperview()
        }
        self.topDropIconImageView.snp.makeConstraints { (make) in
            make.left.equalTo(self.topCurrencyLabel.snp.right).offset(16)
            make.right.equalToSuperview()
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 12, height: 8))
        }
        self.topValueTextField.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview().inset(60)
            make.right.equalToSuperview().inset(20)
        }
        
        self.centerView.snp.makeConstraints { (make) in
            make.top.equalTo(self.topView.snp.bottom).inset(18)
            make.left.right.equalToSuperview()
        }
        self.centerChangeButton.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().inset(20)
            make.size.equalTo(36)
        }
        self.centerValueView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.height.equalTo(36)
        }
        self.centerChartImageView.snp.makeConstraints { (make) in
            make.top.left.bottom.equalToSuperview().inset(13)
            make.size.equalTo(CGSize(width: 17, height: 10))
        }
        self.centerValueLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.centerChartImageView.snp.right).offset(10)
            make.right.equalToSuperview().inset(13)
            make.centerY.equalToSuperview()
        }
        
        self.bottomView.snp.makeConstraints { (make) in
            make.top.equalTo(self.topView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
        self.bottomCurrencyView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(60)
            make.left.equalToSuperview().inset(20)
        }
        self.bottomCurrencyLabel.snp.makeConstraints { (make) in
            make.top.left.bottom.equalToSuperview()
        }
        self.bottomDropIconImageView.snp.makeConstraints { (make) in
            make.left.equalTo(self.bottomCurrencyLabel.snp.right).offset(16)
            make.right.equalToSuperview()
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 12, height: 8))
        }
        self.bottomValueLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(60)
            make.right.equalToSuperview().inset(20)
        }
        self.footerFloatButton.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(36)
            make.bottom.equalToSuperview().inset(50)
            make.height.equalTo(48)
        }
    }
    
    //MARK: - Actions

    @objc private func closeBarButtonTapped(_ sender: UIBarButtonItem) {
        self.closeButtonTappedHandler?()
    }
    
    @objc private func shareBarButtonTapped(_ sender: UIBarButtonItem) {
        print("share")
    }
    
    @objc private func changeButtonTapped(_ sender: UIButton) {
        self.animateViewsOnChangeButtomTapped()
    }
    
    @objc private func topViewTapped() {
        let currenciesVC = CurrenciesViewController()
        currenciesVC.modalPresentationStyle = .custom
        currenciesVC.transitioningDelegate = self
        self.present(currenciesVC, animated: true, completion: nil)
    }
    
    @objc private func footerFloatButtonTapped(_ sender: UIButton) {
        sender.tapAnimation {
            
        }
    }
    
    @objc private func keyboardDoneButtonTapped() {
        self.view.endEditing(true)
    }
    
    @objc private func topTextFieldValueChanged(_ sender: UITextField) {
        guard let text = sender.text,
              let value = Float(text),
              text != "" else {
            self.bottomValueLabel.text = "0"
            return
        }
        let total = value * self.currentMultilier
        let totalStr = String(format: "%0.2f", total)
        UIView.transition(with: self.bottomValueLabel,
                          duration: 0.1,
                          options: .transitionCrossDissolve) { [weak self] in
            self?.bottomValueLabel.text = totalStr
        }
    }
    
    //MARK: - Setters
    
    private func addSubviews() {
        self.view.insertSubview(self.topView, at: 0)
        self.topView.addSubview(self.topCurrencyView)
        self.topView.addSubview(self.topValueTextField)
        self.topCurrencyView.addSubview(self.topCurrencyLabel)
        self.topCurrencyView.addSubview(self.topDropIconImageView)
        
        self.view.insertSubview(self.centerView, at: 2)
        self.centerView.addSubview(self.centerChangeButton)
        self.centerView.addSubview(self.centerValueView)
        self.centerValueView.addSubview(self.centerChartImageView)
        self.centerValueView.addSubview(self.centerValueLabel)
        
        self.view.insertSubview(self.bottomView, at: 1)
        self.bottomView.addSubview(self.bottomCurrencyView)
        self.bottomView.addSubview(self.bottomValueLabel)
        self.bottomCurrencyView.addSubview(self.bottomCurrencyLabel)
        self.bottomCurrencyView.addSubview(self.bottomDropIconImageView)
        
        self.view.addSubview(self.footerFloatButton)
    }
    
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationItem.title = "Конвертация"
        self.navigationItem.leftBarButtonItem = self.closeBarButton
        self.navigationItem.rightBarButtonItem = self.shareBarButton
    }
    
    //MARK: - Animations
    
    private func animateViewsOnChangeButtomTapped() {
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.centerChangeButton.transform = CGAffineTransform(rotationAngle: .pi)
        } completion: { [weak self] (done) in
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
                weakSelf.topCurrencyLabel.text = weakSelf.fromCurrency
                
                weakSelf.bottomCurrencyView.transform = CGAffineTransform.identity
                weakSelf.bottomCurrencyLabel.text = weakSelf.toCurrency
                
                let tmp = weakSelf.toCurrency
                weakSelf.toCurrency = weakSelf.fromCurrency
                weakSelf.fromCurrency = tmp
            }

        }
    }
    
}

extension ConvertViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        CurrenciesPresentationController(presentedViewController: presented, presenting: presenting)
    }
}
