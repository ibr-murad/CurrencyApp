//
//  HeaderDetailViewController.swift
//  CurrencyApp
//
//  Created by Humo Programmer  on 10/13/20.
//

import UIKit

class HeaderDetailViewController: UIViewController {
    
    //MARK: - Public variables
    
    //MARK: - Private variables
    
    private let identifier = "HeaderDetailTableViewCell"
    private var navigationBarBackgroundImage: UIImage?
    private var isSwipeAnimationEnded: Bool = true
    private let defaultGradientColors: [UIColor] = [
        .init(rgb: 0xDE5000, alpha: 1),
        .init(rgb: 0xFC8D26, alpha: 1)]
    private let defaultShadowColor: UIColor = .init(rgb: 0xFB8B25, alpha: 0.52)
    
    //MARK: - GUI variables
    
    private lazy var shareBarButton: UIBarButtonItem = {
        var button = UIBarButtonItem(
            image: UIImage(named: "share"), style: .plain,
            target: self, action: #selector(self.shareBarButtonTapped))
        button.tintColor = .white
        return button
    }()
    
    private lazy var logoImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "humoWhite")
        imageView.tag = 22
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var topContainerView: UIView = {
        var view = UIView()
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tag = 1
        return view
    }()
    
    private lazy var topView: HeaderDetailTopView = {
        var view = HeaderDetailTopView()
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(self.topViewSwippedDown))
        swipeDown.direction = .down
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(self.topViewSwippedUp))
        swipeUp.direction = .up
        view.addGestureRecognizer(swipeDown)
        view.addGestureRecognizer(swipeUp)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var tableView: UITableView = {
        var tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .white
        tableView.separatorStyle = .singleLine
        tableView.rowHeight = 55
        tableView.showsVerticalScrollIndicator = false
        tableView.tableHeaderView?.backgroundColor = .clear
        tableView.tableFooterView = UIView()
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: self.identifier)
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

    @objc func notifi() {
        print("notifi")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        AppDelegate.shared.rootViewController.isBlackStatusBar = false
        self.setupNavigationBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        AppDelegate.shared.rootViewController.isBlackStatusBar = true
        self.navigationController?.navigationBar.setBackgroundImage(
            self.navigationBarBackgroundImage, for: .default)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.updateGradientAndShadowColor(
            gradient: self.defaultGradientColors, shadow: self.defaultShadowColor)
    }
    
    //MARK: - Constraints
    
    private func makeConstraints() {
        self.topContainerView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
        }
        self.topView.snp.makeConstraints { (make) in
            make.top.equalTo(self.topLayoutGuide.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
        self.tableView.snp.makeConstraints { (make) in
            make.top.equalTo(self.topContainerView.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.greaterThanOrEqualToSuperview()
        }
    }
    
     //MARK: - Setters
    
    private func addSubviews() {
        self.view.addSubview(self.tableView)
        self.view.addSubview(self.topContainerView)
        self.topContainerView.addSubview(self.topView)
    }
    
    func updateGradientAndShadowColor(gradient colors: [UIColor], shadow color: UIColor) {
        let gradientRect = self.topContainerView.bounds
        self.topContainerView.setGradient(rect: gradientRect, colors: colors)
        self.topContainerView.dropShadow(color: color, offSet: .init(width: 0, height: 8), radius: 20)
    }
    
    private func setupNavigationBar() {
        self.navigationItem.titleView = self.logoImageView
        self.navigationBarBackgroundImage =
            self.navigationController?.navigationBar.backgroundImage(for: .default)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationItem.rightBarButtonItem = self.shareBarButton
        if #available(iOS 11.0, *) {
            self.navigationItem.largeTitleDisplayMode = .never
        }
    }
    
    //MARK: - Actions
    
    @objc private func topViewSwippedDown(_ sender: UISwipeGestureRecognizer) {
        self.topView.isOpenState = true
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
            self.isSwipeAnimationEnded = false
        } completion: { (finish) in
            self.isSwipeAnimationEnded = true
            self.viewDidLayoutSubviews()
        }
    }
    
    @objc private func topViewSwippedUp(_ sender: UISwipeGestureRecognizer) {
        self.topView.isOpenState = false
        UIView.animate(withDuration: 0.5) {
            self.isSwipeAnimationEnded = false
            self.view.layoutIfNeeded()
        } completion: { (finish) in
            self.isSwipeAnimationEnded = true
            self.viewDidLayoutSubviews()
        }
    }
    
    @objc private func shareBarButtonTapped(_ sender: UIButton) {
        print("tap")
    }
    
}

//MARK: - UITableViewDelegate, UITableViewDataSource

extension HeaderDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: self.identifier)
        
        cell.textLabel?.text = "Title text"
        cell.imageView?.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        cell.selectionStyle = .none
        
        let randomDetailText = "\(Int.random(in: 10...20))"
        
        if indexPath.row % 4 == 0 {
            cell.detailTextLabel?.text = "-" + randomDetailText
            cell.imageView?.image =  UIImage(named: "chartdown")
            cell.detailTextLabel?.textColor = .systemRed
        } else {
            cell.detailTextLabel?.text = "+" + randomDetailText
            cell.imageView?.image =  UIImage(named: "chartup")
            cell.detailTextLabel?.textColor = .systemGreen
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
    }
    
}
