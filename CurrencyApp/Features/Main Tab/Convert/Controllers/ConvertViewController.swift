//
//  ConvertViewController.swift
//  CurrencyApp
//
//  Created by Humo Programmer on 10/8/20.
//

import UIKit

class ConvertViewController: UIViewController {
    
    //MARK: - Public variables
    
    var closeButtonTappedHandler: (() -> Void)?

    //MARK: - Private variables
    
    private var fromCurrency = "RUB" {
        willSet {
            self.convertView.topCurrencyLabel.text = newValue
        }
    }
    private var toCurrency = "TJS" {
        willSet {
            self.convertView.bottomCurrencyLabel.text = newValue
        }
    }
    
    private var fromMultiplier: Float {
        guard let model = self.multipliers[self.fromCurrency] else { return 1 }
        return model.getMultiplier()
    }
    
    private var toMultiplier: Float {
        guard let model = self.multipliers[self.toCurrency] else { return 1 }
        return model.getMultiplier()
    }
    
    private var multipliers: [String: Convertable] = [:]
    private var appStoreLink: String = ""
    
    //MARK: - GUI variables
    
    private lazy var convertView: ConvertView = {
        var view = ConvertView()
        view.culculateHandler = { [weak self] in
            self?.culculate()
        }
        view.changeHandler = { [weak self] in
            self?.change()
        }
        let topTap = UITapGestureRecognizer(target: self, action: #selector(self.topViewTapped))
        view.topCurrencyView.addGestureRecognizer(topTap)
        let bottomTap = UITapGestureRecognizer(target: self, action: #selector(self.bottomViewTapped))
        view.bottomCurrencyView.addGestureRecognizer(bottomTap)
        view.downloadButton.addTarget(self, action: #selector(self.downloadButtonTapped), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        self.addObservers()
        self.makeConstraints()
        self.culculate()
    }
    
    func initWithModels<T: Convertable>(_ models: [T], defaultName: String = "RUB") {
        for model in models {
            if model.name == defaultName {
                self.fromCurrency = model.name
            }
            self.multipliers[model.name] = model
        }
    }
    
    func setupModel(image: UIImage? ,colors: ColorsModel? = nil, appStoreLink: String = "") {
        self.setupColors(colors)
        self.appStoreLink = appStoreLink
        self.convertView.downloadButton.setImage(image, for: .normal)
    }
    
    //MARK: - Constraints
    
    private func makeConstraints() {
        self.convertView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    //MARK: - Setters
    
    private func addSubviews() {
        self.view.addSubview(self.convertView)
    }
    
    private func addObservers() {
        NotificationCenter.default.addObserver(
            self, selector: #selector(self.keyboardWillShowNotification),
            name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(
            self, selector: #selector(self.keyboardWillHideNotification),
            name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func setupNavigationBar() {
        self.navigationItem.title = "Конвертация"
        self.navigationItem.leftBarButtonItem = self.closeBarButton
        self.navigationItem.rightBarButtonItem = self.shareBarButton
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    private func setupColors(_ colors: ColorsModel?) {
        if let colorsModel = colors {
            self.convertView.centerChangeButton.tintColor = .init(hex: colorsModel.color_1)
            self.convertView.centerValueLabel.textColor = .init(hex: colorsModel.color_1)
            self.convertView.downloadButton.backgroundColor = .init(hex: colorsModel.color_1)
            self.shareBarButton.tintColor = .init(hex: colorsModel.color_1)
            let image = self.convertView.centerChartImageView.image?.with(color: .init(hex: colorsModel.color_1))
            self.convertView.centerChartImageView.image = image
        }
    }
    
    //MARK: - Actions
    
    @objc private func closeBarButtonTapped(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func shareBarButtonTapped(_ sender: UIBarButtonItem) {
        self.view.endEditing(true)
        let renderer = UIGraphicsImageRenderer(size: self.view.bounds.size)
        let image = renderer.image { ctx in
            self.view.drawHierarchy(in: self.view.bounds, afterScreenUpdates: true)
        }
        let activityVC = UIActivityViewController(activityItems: [image], applicationActivities: [])
        self.view.isUserInteractionEnabled = false
        self.present(activityVC, animated: true, completion: { [weak self] in
            self?.view.isUserInteractionEnabled = true
        })
    }
    
    @objc private func topViewTapped() {
        let currenciesVC = CurrenciesViewController()
        currenciesVC.modalPresentationStyle = .custom
        currenciesVC.transitioningDelegate = self
        currenciesVC.isFullPresentedEnable = true
        var data: [String] = []
        for (k,v) in self.multipliers {
            var string = ""
            string = "\(k) (\(v.full_name))"
            data.append(string)
        }
        currenciesVC.data = data
        currenciesVC.selected = { [weak self] selected in
            self?.fromCurrency = selected
            self?.culculate()
        }
        self.present(currenciesVC, animated: true, completion: nil)
    }
    
    @objc private func bottomViewTapped() {
        let currenciesVC = CurrenciesViewController()
        currenciesVC.modalPresentationStyle = .custom
        currenciesVC.transitioningDelegate = self
        currenciesVC.isFullPresentedEnable = true
        var data: [String] = []
        for (k,v) in self.multipliers {
            var string = ""
            string = "\(k) (\(v.full_name))"
            data.append(string)
        }
        currenciesVC.data = data
        currenciesVC.selected = { [weak self] selected in
            self?.toCurrency = selected
            self?.culculate()
        }
        self.present(currenciesVC, animated: true, completion: nil)
    }
    
    @objc private func downloadButtonTapped(_ sender: UIButton) {
        sender.tapAnimation {
            guard let idRange = self.appStoreLink.index(of: "id") else {
                if let url = URL(string: self.appStoreLink) {
                    UIApplication.shared.open(url)
                }
                return
            }
            let idSubstring = self.appStoreLink[idRange..<self.appStoreLink.endIndex]
            if let url = URL(string: "itms-apps://itunes.apple.com/app/" + String(idSubstring)) {
                UIApplication.shared.open(url)
            }
        }
    }
    
    @objc func keyboardWillShowNotification(_ notification: NSNotification) {
        if let userInfo = notification.userInfo,
           let nsValue = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardFrame = nsValue.cgRectValue
            self.convertView.descriptionView.transform =
                CGAffineTransform(translationX: 0, y: -(keyboardFrame.height - 30))
        }
    }

    @objc func keyboardWillHideNotification(_ notification: NSNotification) {
        self.convertView.descriptionView.transform = CGAffineTransform.identity
    }
        
    //MARK: - Helpers
    
    private func change() {
        let tmp = self.toCurrency
        self.toCurrency = self.fromCurrency
        self.fromCurrency = tmp
        self.culculate()
    }
    
    private func culculate() {
        guard let fieldText = self.convertView.topValueTextField.text,
              let fieldValue = Float(fieldText) else { return }
        let resultValue = (fieldValue * 1 * self.toMultiplier) / (1 * self.fromMultiplier)
        let resultText = String(format: "%0.2f", resultValue)
        self.convertView.bottomValueLabel.text = resultText
        let resultValueOneByOne = (1 * 1 * self.toMultiplier) / (1 * self.fromMultiplier)
        let resultTextOneByOne = String(format: "%0.2f", resultValueOneByOne)
        self.convertView.centerValueLabel.text = "1 \(self.fromCurrency) = \(resultTextOneByOne) \(self.toCurrency)"
    }
    
}


//MARK: - UIViewControllerTransitioningDelegate

extension ConvertViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        CurrenciesPresentationController(presentedViewController: presented, presenting: presenting)
    }
}
