//
//  CurrenciesViewController.swift
//  CurrencyApp
//
//  Created by Humo Programmer  on 10/28/20.
//

import UIKit

class CurrenciesViewController: UIViewController {
    
    //MARK: - Public variables
    
    //MARK: - Private variables
    
    private var data: [String] = ["1", "2", "3"]
    
    private var hasSetPointOrigin = false
    private var pointOrigin: CGPoint?
    
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
        button.setTitle("dismiss", for: .normal)
        button.setTitleColor(.blue, for: .normal)
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
        tableView.isScrollEnabled = false
        tableView.tableHeaderView = UIView()
        tableView.tableFooterView = UIView()
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
            make.top.left.right.equalToSuperview()
            make.height.equalTo(50)
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
            make.top.right.equalToSuperview().inset(40)
            make.height.equalTo(40)
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
        guard let pointOrigin = self.pointOrigin else { return }
        self.view.frame.origin = CGPoint(x: 0, y: pointOrigin.y + translation.y)
        
        /*if sender.state == .ended {
            if self.view.frame.origin.y <= 200 {
                self.titleLabel.snp.remakeConstraints { (make) in
                    make.top.equalTo(self.topLayoutGuide.snp.top).offset(28)
                    make.centerX.equalToSuperview()
                }
                UIView.animate(withDuration: 0.3) {
                    self.view.frame.origin = CGPoint(x: 0, y: 0)
                    self.dismissButton.alpha = 1
                    self.dismissButton.isEnabled = true
                    self.topView.alpha = 0
                    self.topView.isUserInteractionEnabled = false
                    
                    //self.view.layoutIfNeeded()
                    
                }
            } else if self.view.frame.origin.y >= 600 {
                self.dismiss(animated: true, completion: nil)
            } else {
                UIView.animate(withDuration: 0.3) {
                    self.view.frame.origin = self.pointOrigin ?? CGPoint(x: 0, y: 400)
                }
            }
        }*/
        if sender.state == .ended {
            let dragVelocity = sender.velocity(in: self.view)
            
            if dragVelocity.y >= 300 {
                //close
                self.dismiss(animated: true, completion: nil)
            } else if dragVelocity.y <= -300 {
                //open
                self.titleLabel.snp.remakeConstraints { (make) in
                    make.top.equalTo(self.topLayoutGuide.snp.top).offset(28)
                    make.centerX.equalToSuperview()
                }
                UIView.animate(withDuration: 0.3) {
                    self.view.frame.origin = CGPoint(x: 0, y: 0)
                    self.view.roundedCorners(.allCorners, radius: 0)
                    self.dismissButton.alpha = 1
                    self.dismissButton.isEnabled = true
                    self.topView.alpha = 0
                    self.topView.isUserInteractionEnabled = false
                    self.tableView.isScrollEnabled = true
                    self.view.layoutIfNeeded()
                }
            } else {
                //normal
                UIView.animate(withDuration: 0.3) {
                    self.view.frame.origin = self.pointOrigin ?? CGPoint(x: 0, y: 400)
                }
            }
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
        
        return cell
    }
    
}
