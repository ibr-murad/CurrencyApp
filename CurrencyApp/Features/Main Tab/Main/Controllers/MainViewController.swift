//
//  MainViewController.swift
//  CurrencyApp
//
//  Created by Murodjon Ibrohimovon 10/7/20.
//

import UIKit
import SnapKit
import Windless
import Kingfisher

class MainViewController: BaseViewController {
    
    //MARK: - Private variables
    
    private var viewModel = MainControllerViewModel()
    private var npcrData: [BankRatesModel] = []
    private var tkbData: [BankRatesModel] = []
    
    private var isRequestBusy: Bool = false {
        willSet {
            self.segmentedControl.isEnabled = !newValue
        }
    }
    private var isDataLoaded: Bool = false
    
    //MARK: - GUI variables
    
    private lazy var settingsButton: UIButton = {
        var button = UIButton(type: .system)
        button.tintColor = .init(rgb: 0x000000, alpha: 0.87)
        button.setImage(UIImage(named: "settings"), for: .normal)
        button.addTarget(self, action: #selector(self.settingsBarButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var segmentedContainerView: UIView = {
        var view = UIView()
        view.backgroundColor = .init(rgb: 0xF3F4F5)
        view.isOpaque = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var segmentedControl: UISegmentedControl = {
        var segment = UISegmentedControl()
        segment.insertSegment(withTitle: "Обычный", at: 0, animated: true)
        segment.insertSegment(withTitle: "Переводы РФ", at: 1, animated: true)
        segment.selectedSegmentIndex = 0
        segment.addTarget(self, action: #selector(self.segmentedControleValueChanged), for: .valueChanged)
        segment.translatesAutoresizingMaskIntoConstraints = false
        return segment
    }()
    
    private lazy var headerView: MainHeaderView = {
        var view = MainHeaderView()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.headerViewTapped)))
        view.convertButton.addTarget(self, action: #selector(self.headerConvertButtonTapped), for: .touchUpInside)
        view.shareButton.addTarget(self, action: #selector(self.headerShareButtonTapped), for: .touchUpInside)
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
        tableView.estimatedSectionHeaderHeight = 300
        tableView.sectionHeaderHeight = UITableView.automaticDimension
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
        refresh.tintColor = UIColor(hex: "#158C62")
        refresh.addTarget(self, action: #selector(self.refreshControlValueChanged), for: .valueChanged)
        refresh.translatesAutoresizingMaskIntoConstraints = false
        return refresh
    }()
    
    //MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .init(rgb: 0xF3F4F5)
        
        self.setupNavigationBar()
        self.addSubviews()
        self.makeConstraints()
        self.addObservers()
        self.startLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if #available(iOS 11.0, *) {
            navigationItem.largeTitleDisplayMode = .always
        }
        
        self.setHiddenSttingsButton(false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.setHiddenSttingsButton(true)
    }
    
    
    //MARK: - Constraints
    
    private func makeConstraints() {
        self.segmentedContainerView.snp.makeConstraints { (make) in
            if #available(iOS 11.0, *) {
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            } else {
                make.top.equalTo(self.topLayoutGuide.snp.bottom)
            }
            make.left.right.equalToSuperview()
        }
        self.segmentedControl.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(8)
            make.left.right.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(12)
        }
        self.tableView.snp.makeConstraints { (make) in
            make.top.equalTo(self.segmentedControl.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
        self.settingsButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(15)
            make.size.equalTo(20)
        }
    }
    
    //MARK: - Setters
    
    private func addSubviews() {
        self.view.addSubview(self.tableView)
        self.view.addSubview(self.segmentedContainerView)
        self.segmentedContainerView.addSubview(self.segmentedControl)
    }
    
    private func setupNavigationBar() {
        self.navigationItem.title = "Выгодный курс"
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Курс", style: .plain, target: nil, action: nil)
        self.navigationController?.navigationBar.addSubview(self.settingsButton)
    }
    
    private func addObservers() {
        NotificationCenter.default.addObserver(
            self, selector: #selector(self.defaultSettingsUpdated),
            name: .defaultCurrencyUpdated, object: nil)
    }
    
    private func setHiddenSttingsButton(_ value: Bool) {
        self.settingsButton.isHidden = value
        self.settingsButton.isEnabled = !value
    }
    
    //MARK: - Actions
    
    @objc private func segmentedControleValueChanged(_ sender: UISegmentedControl) {
        if !self.tableView.isAtTop {
            UIView.animate(withDuration: 1) {
                self.tableView.setContentOffset(.zero, animated: true)
            } completion: { (_) in
                self.startLoad()
            }
        } else {
            self.startLoad()
        }
    }
    
    @objc private func refreshControlValueChanged(_ sender: UIRefreshControl) {
        sender.beginRefreshing()
        self.startLoad()
    }
    
    @objc private func settingsBarButtonTapped(_ sender: UIButton) {
        Interface.shared.pushVC(vc: SettingsViewController())
    }
    
    @objc private func headerViewTapped() {
        guard let bank = self.viewModel.bestBank else { return }
        self.headerView.tapAnimation {
            self.showDetail(for: bank)
        }
    }
    
    @objc private func headerShareButtonTapped() {
        let renderer = UIGraphicsImageRenderer(size: self.headerView.bounds.size)
        let image = renderer.image { ctx in
            self.headerView.shareButton.isHidden = true
            self.headerView.drawHierarchy(in: self.headerView.bounds, afterScreenUpdates: true)
            self.headerView.shareButton.isHidden = false
        }
        let activityVC = UIActivityViewController(activityItems: [image], applicationActivities: [])
        self.view.isUserInteractionEnabled = false
        self.present(activityVC, animated: true, completion: { [weak self] in
            self?.view.isUserInteractionEnabled = true
        })
    }
    
    @objc private func headerConvertButtonTapped() {
        guard let bank = self.viewModel.bestBank else { return }
        self.showConvert(for: bank)
    }
    
    @objc private func defaultSettingsUpdated() {
        self.startLoad()
    }
    
    //MARK: - Network
    
    private func fetchData() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(1)) {
            let url: URLPath = self.segmentedControl.selectedSegmentIndex == 0 ? .npcr_bank_rates : .c2c_bank_rates
            //Network.shared.testRequest { [weak self] (response: Result<[BankRatesModel], NetworkError>) in
            Network.shared.request(url: url) { [weak self] (response: Result<[BankRatesModel], NetworkError>) in
                guard let self = self else { return }
                switch response {
                case .success(let models):
                    try? CodableStorage.shared.save(models, for: url.rawValue)
                    UserDefaults.standard.saveLastUpdate()
                    break
                case .failure(let error):
                    print(error)
                    break
                }
                do{
                    let fethchedModels: [BankRatesModel] = try CodableStorage.shared.fetch(for: url.rawValue)
                    self.viewModel = MainControllerViewModel(models: fethchedModels, type: .type1)
                    if self.segmentedControl.selectedSegmentIndex == 0 {
                        self.viewModel = MainControllerViewModel(models: fethchedModels, type: .type1)
                    } else {
                        self.viewModel = MainControllerViewModel(models: fethchedModels, type: .type2)
                    }
                } catch {
                    print(error)
                }
                self.endLoading()
            }
        }
        self.refreshControl.endRefreshing()
    }
    
    private func startLoad() {
        guard !self.isRequestBusy else {
            self.refreshControl.endRefreshing()
            return
        }
        self.tableView.isUserInteractionEnabled = false
        self.tableView.windless
            .apply {
                $0.beginTime = 0.5
                $0.duration = 1.5
                $0.animationLayerOpacity = 0.2
            }.start()
        self.isRequestBusy = true
        self.isDataLoaded = false
        self.fetchData()
    }
    
    private func endLoading() {
        if let bestRateModel = self.viewModel.bestBank {
            self.headerView.type = self.viewModel.type
            self.headerView.initView(model: bestRateModel)
        }
        self.isRequestBusy = false
        self.isDataLoaded = true
        self.tableView.windless.end()
        self.tableView.isUserInteractionEnabled = true
        self.tableView.reloadData()
    }
    
    //MARK: - Helpers
    
    private func showDetail(for bank: BankRatesModel) {
        let controller = DetailViewController()
        controller.initWithModel(bank)
        let navController = UINavigationController(rootViewController: controller)
        self.present(navController, animated: true, completion: nil)
    }
    
    private func showConvert(for bank: BankRatesModel) {
        let convertController = ConvertViewController()
        let navController = UINavigationController(rootViewController: convertController)
        convertController.initWithModels(bank.currency, defaultName: self.headerView.currencyName)
        bank.getImage { (image) in
            convertController.setupModel(image: image, colors: bank.colors, appStoreLink: bank.appStoreLink)
        }
        self.present(navController, animated: true, completion: nil)
    }
    
    private func showActionSheet(forCellAt indexPath: IndexPath) {
        let actionSheet = UIAlertController(
            title: self.viewModel.banks[indexPath.row].name,
            message: "Выберите действие",
            preferredStyle: .actionSheet)
        guard let cell = self.tableView.cellForRow(at: indexPath) as? MainTableViewCell else { return }
        actionSheet.addAction(UIAlertAction(title: "Поделиться", style: .default, handler: { [weak self] (_) in
            guard let self = self else { return }
            let renderer = UIGraphicsImageRenderer(size: cell.contentView.bounds.size)
            let image = renderer.image { ctx in
                cell.detailButton.isHidden = true
                cell.contentView.drawHierarchy(in: cell.contentView.bounds, afterScreenUpdates: true)
                cell.detailButton.isHidden = false
            }
            let activityVC = UIActivityViewController(activityItems: [image], applicationActivities: [])
            self.view.isUserInteractionEnabled = false
            self.present(activityVC, animated: true, completion: { [weak self] in
                self?.view.isUserInteractionEnabled = true
            })
        }))
        actionSheet.addAction(UIAlertAction(title: "Конвертировать", style: .default, handler: { [weak self] (_) in
            guard let bank = self?.viewModel.banks[indexPath.row] else { return }
            self?.showConvert(for: bank)
        }))
        actionSheet.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
    }
    
}

//MARK: - UITableViewDelegate, UITableViewDataSource

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return self.headerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.isDataLoaded {
            return self.viewModel.banks.count
        }
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.reuseIdentifier, for: indexPath)
        if self.isDataLoaded {
            let viewModel = self.viewModel.banks[indexPath.row]
            (cell as? MainTableViewCell)?.type = self.viewModel.type
            (cell as? MainTableViewCell)?.initCell(model: viewModel)
            (cell as? MainTableViewCell)?.deteailSelected = { [weak self] in
                self?.showActionSheet(forCellAt: indexPath)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = self.tableView.cellForRow(at: indexPath) as? MainTableViewCell else { return }
        let bank = self.viewModel.banks[indexPath.row]
        cell.containerView.tapAnimation { [weak self] in
            self?.showDetail(for: bank)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let barHeght = self.navigationController?.navigationBar.bounds.height else { return }
        let verticalOffset = scrollView.contentOffset.y + barHeght
        if verticalOffset > barHeght {
            self.segmentedContainerView.transform = CGAffineTransform.identity
            self.segmentedContainerView.backgroundColor = .init(rgb: 0xFAFAFA)
        } else if verticalOffset == barHeght {
            self.segmentedContainerView.transform = CGAffineTransform.identity
            self.segmentedContainerView.backgroundColor = .init(rgb: 0xF3F4F5)
        } else {
            self.segmentedContainerView.transform = CGAffineTransform(translationX: 0, y: -scrollView.contentOffset.y)
            self.segmentedContainerView.backgroundColor = .init(rgb: 0xF3F4F5)
        }
    }
    
}
