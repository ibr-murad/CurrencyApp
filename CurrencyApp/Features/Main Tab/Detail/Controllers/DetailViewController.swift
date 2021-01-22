//
//  DetailViewController.swift
//  CurrencyApp
//
//  Created by Murodjon Ibrohimovon 10/13/20.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {
    
    //MARK: - Public variables
    
    //MARK: - Private variables
    
    private let identifier = "HeaderDetailTableViewCell"
    private var isSwipeAnimationEnded: Bool = true
    private var model: BankRatesModel?

    //MARK: - GUI variables
    
    private lazy var shareBarButton: UIBarButtonItem = {
        var button = UIBarButtonItem(
            image: UIImage(named: "share"), style: .plain,
            target: self, action: #selector(self.shareBarButtonTapped))
        button.tintColor = .white
        return button
    }()
    
    private lazy var dismissBarButton: UIBarButtonItem = {
        var button = UIBarButtonItem(
            image: UIImage(named: "close"), style: .plain,
            target: self, action: #selector(self.dismissButtonTapped))
        button.tintColor = .white
        return button
    }()
    
    private lazy var logoConteinerView: UIView = {
        var view = UIView()
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var logoView: UIView = {
        var view = UIView()
        view.clipsToBounds = false
        return view
    }()
    
    private lazy var logoImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var logoNameLabel: UILabel = {
        var label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.textColor = .white
        return label
    }()
    
    private lazy var topContainerView: UIView = {
        var view = UIView()
        view.clipsToBounds = true
        view.tag = 1
        return view
    }()
    
    private lazy var topView: DetailTopView = {
        var view = DetailTopView()
        view.convertButton.addTarget(self, action: #selector(self.convertButtonTapped), for: .touchUpInside)
        return view
    }()
    
    private lazy var lastUpdateLabel: UILabel = {
        var label = UILabel()
        label.text = "Последний раз обновлено " + UserDefaults.standard.lastUpdated
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()

    //MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.addSubviews()
        self.makeConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setupNavigationBar()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.updateGradientAndShadowColor()
    }
    
    func initWithModel(_ model: BankRatesModel) {
        self.model = model
        self.topView.initView(model)
        self.logoNameLabel.text = model.name
        model.getImage { (image) in
            self.logoImageView.image = image
        }
    }
    
    //MARK: - Constraints
    
    private func makeConstraints() {
        
        self.logoConteinerView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(16)
            make.centerX.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.width - 100)
        }
        self.logoView.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.greaterThanOrEqualToSuperview()
            make.centerX.equalToSuperview()
        }
        self.logoImageView.snp.updateConstraints { (make) in
            make.top.left.bottom.equalToSuperview()
            make.size.equalTo(24)
        }
        self.logoNameLabel.snp.updateConstraints { (make) in
            make.top.right.bottom.equalToSuperview()
            make.left.equalTo(self.logoImageView.snp.right).offset(8)
        }
        self.topContainerView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
        }
        self.topView.snp.makeConstraints { (make) in
            if #available(iOS 11.0, *) {
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            } else {
                make.top.equalTo(self.topLayoutGuide.snp.top)
            }
            make.left.right.bottom.equalToSuperview()
        }
        
        self.lastUpdateLabel.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().inset(48)
            make.centerX.equalToSuperview()
        }

    }
    
     //MARK: - Setters
    
    private func addSubviews() {
        self.view.addSubview(self.logoConteinerView)
        self.logoConteinerView.addSubview(self.logoView)
        self.logoView.addSubview(self.logoImageView)
        self.logoView.addSubview(self.logoNameLabel)
        self.view.addSubview(self.topContainerView)
        self.topContainerView.addSubview(self.topView)
        self.view.addSubview(self.lastUpdateLabel)
    }
    
    func updateGradientAndShadowColor(_ colorsModel: ColorsModel? = nil) {
        let gradientRect = self.view.bounds
        var gradientColors: [UIColor] = [.init(rgb: 0x000000), .init(rgb: 0x000000)]
        if let model = self.model {
            gradientColors = [.init(hex: model.colors.color_1), .init(hex: model.colors.color_2)]
        }
        self.view.setGradient(rect: gradientRect, colors: gradientColors)
    }
    
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationItem.rightBarButtonItem = self.shareBarButton
        self.navigationItem.leftBarButtonItem = self.dismissBarButton
        if #available(iOS 11.0, *) {
            self.navigationItem.largeTitleDisplayMode = .never
        }
    }
    
    //MARK: - Actions
    
    @objc private func dismissButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func shareBarButtonTapped(_ sender: UIButton) {
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
    
    @objc private func convertButtonTapped(_ sender: UIButton) {
        guard let bank = self.model else { return }
        let convertController = ConvertViewController()
        let navController = UINavigationController(rootViewController: convertController)
        convertController.initWithModels(bank.currency)
        bank.getImage { (image) in
            convertController.setupModel(image: image, colors: bank.colors, appStoreLink: bank.appStoreLink)
        }
        self.present(navController, animated: true, completion: nil)
    }
}
