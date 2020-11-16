//
//  CurrenciesViewController.swift
//  CurrencyApp
//
//  Created by Humo Programmer on 10/28/20.
//

import UIKit

class CurrenciesViewController: UIViewController {
    
    //MARK: - Public variables
    
    var isFullPresentedEnable = false
    var selected: ((String) -> Void)?
    var data: [String] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    //MARK: - Private variables
    
    private var hasSetPointOrigin = false
    private var pointOrigin: CGPoint?
    private var finalPoint = CGPoint(x: 0, y: 0)
    private var isFullPresented = false {
        willSet {
            self.tableView.isScrollEnabled = newValue
        }
    }
    
    
    enum ViewState {
        case open
        case close
        case normal
    }
    
    //MARK: - GUI variables
    
    private lazy var topView: UIView = {
        var view = UIView()
        view.isUserInteractionEnabled = true
        view.backgroundColor = .clear
        let pan = UIPanGestureRecognizer(target: self, action: #selector(self.topViewPan))
        view.addGestureRecognizer(pan)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var topDarkIndicatorView: UIView = {
        var view = UIView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        var label = UILabel()
        label.text = "Выберите валюту"
        label.textAlignment = .center
        label.textColor = Colors.textBlackMain.color()
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var dismissButton: UIButton = {
        var button = UIButton()
        button.setImage(UIImage(named: "closeGray"), for: .normal)
        button.layer.cornerRadius = 12
        button.backgroundColor = .init(rgb: 0x818C99, alpha: 0.12)
        button.addTarget(self, action: #selector(self.dismissButtonTapped), for: .touchUpInside)
        button.alpha = 0
        button.isEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var tableView: UITableView = {
        var tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.isScrollEnabled = false
        tableView.register(CurrencyTableViewCell.self, forCellReuseIdentifier: CurrencyTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    //MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.addSubviews()
        self.makeConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if !self.hasSetPointOrigin {
            self.hasSetPointOrigin = true
            self.pointOrigin = self.view.frame.origin
        }
    }
    
    //MARK: - Constraints
    
    private func makeConstraints() {
        self.topView.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalToSuperview()
            //make.height.equalTo(50)
        }
        self.topDarkIndicatorView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(12)
            make.height.equalTo(3)
            make.width.equalTo(32)
            make.centerX.equalToSuperview()
        }
        self.titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(28)
            make.centerX.equalToSuperview()
        }
        self.dismissButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.titleLabel.snp.centerY)
            make.right.equalToSuperview().inset(20)
            make.size.equalTo(24)
        }
        self.tableView.snp.makeConstraints { (make) in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(20)
            make.left.right.bottom.equalToSuperview().inset(20)
        }
    }
    
    //MARK: - Setters
    
    private func addSubviews() {
        self.view.addSubview(self.topView)
        self.topView.addSubview(self.topDarkIndicatorView)
        self.view.addSubview(self.tableView)
        self.view.addSubview(self.titleLabel)
        self.view.addSubview(self.dismissButton)
    }
    
    //MARK: - Actions
    
    @objc private func dismissButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func topViewPan(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: self.view)
        
        if !self.isFullPresented {
            guard let pointOrigin = self.pointOrigin else { return }

            if self.isFullPresentedEnable {
                guard translation.y > -pointOrigin.y else {
                    self.setViewState(.open)
                    return
                }
                self.view.frame.origin = CGPoint(x: 0, y: pointOrigin.y + translation.y)
            } else {
                guard translation.y >= 0 else { return }
                self.view.frame.origin = CGPoint(x: 0, y: pointOrigin.y + translation.y)
            }
        } else {
            guard translation.y > 0 else { return }
            self.view.frame.origin = CGPoint(x: 0, y: self.finalPoint.y + translation.y)
        }
        
        if sender.state == .ended {
            let viewY = self.view.frame.origin.y
            let viewHeigth = self.view.frame.size.height
            
            if viewY >= 0 && viewY <= viewHeigth * 0.3 {
                AppDelegate.shared.rootViewController.isBlackStatusBar = true
                self.setViewState(.open)
            } else if viewY > viewHeigth * 0.6{
                self.setViewState(.close)
            } else {
                self.setViewState(.normal)
            }
        }
    }
    
    private func setViewState(_ state: ViewState) {
        switch state {
        case .normal:
            self.isFullPresented = false
            UIView.animate(withDuration: 0.3) {
                self.view.frame.origin = self.pointOrigin ?? CGPoint(x: 0, y: 400)
                self.view.roundedCorners([.topLeft, .topRight], radius: 20)
                self.topDarkIndicatorView.alpha = 1
                self.view.layoutIfNeeded()
            }
            break
        case .open:
            self.isFullPresented = true
            self.titleLabel.snp.remakeConstraints { (make) in
                if #available(iOS 11.0, *) {
                    make.top.equalTo(self.view.safeAreaLayoutGuide).offset(8)
                } else {
                    make.top.equalToSuperview().inset(8)
                }
                make.centerX.equalToSuperview()
            }
            self.dismissButton.snp.remakeConstraints { (make) in
                make.centerY.equalTo(self.titleLabel.snp.centerY)
                make.right.equalToSuperview().inset(40)
                make.size.equalTo(24)
            }
            UIView.animate(withDuration: 0.3) {
                self.view.frame.origin = CGPoint(x: 0, y: 0)
                self.view.roundedCorners([.topLeft, .topRight], radius: 0)
                self.topDarkIndicatorView.alpha = 0
                self.dismissButton.alpha = 1
                self.dismissButton.isEnabled = true
                self.view.layoutIfNeeded()
            }
            break
        case .close:
            self.isFullPresented = false
            self.dismiss(animated: true, completion: nil)
            break
        }
    }
    
}

//MARK: - UITableViewDelegate, UITableViewDataSource

extension CurrenciesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyTableViewCell.identifier, for: indexPath)
        (cell as? CurrencyTableViewCell)?.initCell(title: self.data[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selected?(String(self.data[indexPath.row].prefix(3)))
        self.dismiss(animated: true, completion: nil)
    }
    
}
