//
//  MainViewController.swift
//  CurrencyApp
//
//  Created by Humo Programmer  on 10/7/20.
//

import UIKit
import SnapKit

class MainViewController: BaseViewController {
    
    //MARK: - Public variables
    
    //MARK: - Private variables
    
    private var data: [String] = Array.init(repeating: "Item", count: 7)
    
    //MARK: - GUI variables
    
    private lazy var settingsButton: UIButton = {
        var button = UIButton(type: .system)
        button.tintColor = .init(rgb: 0x000000, alpha: 0.87)
        button.setImage(UIImage(named: "settings"), for: .normal)
        button.addTarget(self, action: #selector(self.settingsBarButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var headerView: MainHeaderView = {
        var view = MainHeaderView(color: .green)
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.headerViewTapped))
        view.addGestureRecognizer(tap)
        view.tag = 1
        return view
    }()
    
    private lazy var tableView: UITableView = {
        var tableView = UITableView(frame: .zero, style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .init(rgb: 0xF3F4F5)
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 170
        tableView.rowHeight = UITableView.automaticDimension
        tableView.showsVerticalScrollIndicator = false
        if #available(iOS 10.0, *) {
            tableView.refreshControl = self.refreshControl
        } else {
            tableView.addSubview(self.refreshControl)
        }
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.reuseIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    private lazy var refreshControl: UIRefreshControl = {
        var refresh = UIRefreshControl()
        refresh.tintColor = .red
        refresh.addTarget(self, action: #selector(self.refreshControlValueChanged), for: .valueChanged)
        refresh.translatesAutoresizingMaskIntoConstraints = false
        return refresh
    }()

    
    //MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.delegate = self
        self.view.backgroundColor = .init(rgb: 0xF3F4F5)
        
        self.setupNavigationBar()
        self.addSubviews()
        self.makeConstraints()
        self.addObservers()
        self.loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setHiddenSttengsButton(false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.setHiddenSttengsButton(true)
    }

    //MARK: - Constraints
    
    private func makeConstraints() {
        self.tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        self.settingsButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(15)
            make.size.equalTo(20)
        }
    }
    
    //MARK: - Setters
    
    private func setupNavigationBar() {
        self.navigationItem.title = "Выгодный курс"
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Курс", style: .plain, target: nil, action: nil)
        self.navigationController?.navigationBar.addSubview(self.settingsButton)
    }
    
    private func addSubviews() {
        self.view.addSubview(self.tableView)
    }
    
    private func addObservers() {
        NotificationCenter.default.addObserver(
            self, selector: #selector(self.headerConvertButtonTapped(_:)),
            name: .headerConvertButtonTapped, object: nil)
    }
    
    private func setHiddenSttengsButton(_ value: Bool) {
        self.settingsButton.isHidden = value
        self.settingsButton.isEnabled = !value
    }
    
    //MARK: - Actions
    
    @objc private func refreshControlValueChanged(_ sender: UIRefreshControl) {
        sender.beginRefreshing()
        self.loadData()
    }
    
    @objc private func settingsBarButtonTapped(_ sender: UIButton) {
        Interface.shared.pushVC(vc: SettingsViewController())
    }
    
    @objc private func headerViewTapped() {
        let controller = HeaderDetailViewController()
        controller.transitioningDelegate = self
        self.headerView.tapAnimation {
            Interface.shared.pushVC(vc: controller)
        }
    }
    
    @objc private func headerConvertButtonTapped(_ notification: Notification) {
        let convertController = ConvertViewController()
        let navController = UINavigationController(rootViewController: convertController)
        self.present(navController, animated: true, completion: nil)
        convertController.closeButtonTappedHandler = { [weak self] in
            self?.dismiss(animated: true, completion: nil)
        }
    }
    
    //MARK: - Network
    
    private func loadData() {
        print("begin loading...")
            /*Network.shared.request(url: "") { (response: Result<[TestModel], NetworkError>) in
            switch response {
            case .success(let models):
                models.forEach {
                    print($0.id)
                }
                break
            case .failure(let error):
                print(error)
                break
            }
            self.refreshControl.endRefreshing()
            print("end loading...")
        }*/
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(4)) {
            [weak self] in
            guard let self = self else { return }
            self.refreshControl.endRefreshing()
            //self.headerView.setColor(color: .red)
            print("end loading...")
        }

    }

    //MARK: - Helpers
    
    private func showActionSheet(for bankWithId: String) {//cellAtIndexPath: IndexPath) {
        let bankName = "Bank \(bankWithId)"
        let actionSheet = UIAlertController(
            title: bankName, message: "Выберите действие",
            preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Отправить", style: .default, handler: { [weak self] (_) in
            print("Share " + bankName)
        }))
        actionSheet.addAction(UIAlertAction(title: "Конвертировать", style: .default, handler: { [weak self] (_) in
            print("Convert " + bankName)
        }))
        actionSheet.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: { [weak self] (_) in
            print("Cancel " + bankName)
        }))
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
}

//MARK: - UITableViewDelegate, UITableViewDataSource

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return self.headerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.reuseIdentifier, for: indexPath)
        (cell as? MainTableViewCell)?.initCell(bankID: "Bank \(indexPath.row)")
        (cell as? MainTableViewCell)?.deteailSelected = { [weak self] id in
            self?.showActionSheet(for: id)
        }
        return cell
    }
    
}

//MARK: - UIViewControllerTransitioningDelegate, UINavigationControllerDelegate

extension MainViewController: UIViewControllerTransitioningDelegate, UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if viewController is SettingsViewController {
            self.navigationItem.backBarButtonItem?.tintColor = nil
        }
        if viewController is HeaderDetailViewController {
            self.navigationItem.backBarButtonItem?.tintColor = .white
        }
    }
    
    func navigationController(_ navigationController: UINavigationController,
                              animationControllerFor operation: UINavigationController.Operation,
                              from fromVC: UIViewController,
                              to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        var transition: UIViewControllerAnimatedTransitioning? = nil
        if operation == .push {
            if toVC is HeaderDetailViewController {
                transition = animationController(forPresented: fromVC, presenting: toVC, source: fromVC)
            }
        } else {
            if toVC is MainViewController && fromVC is HeaderDetailViewController {
                transition = animationController(forDismissed: toVC)
            }
        }
        return nil
    }
    
    func animationController(forPresented presented: UIViewController,
                             presenting: UIViewController,
                             source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animator = MatchTransitionAnimator()
        animator.isPresenting = true
        return animator
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animator = MatchTransitionAnimator()
        animator.isPresenting = false
        return animator
    }
    
}