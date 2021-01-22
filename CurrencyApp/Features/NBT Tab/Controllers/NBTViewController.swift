//
//  ThirdTabViewController.swift
//  CurrencyApp
//
//  Created by Murodjon Ibrohimovon 11/2/20.
//

import UIKit

class NBTViewController: BaseViewController {
    
    //MARK: - Private variables
    
    private var data: [NBTRateModel] = []
    private var isRequestBusy: Bool = false
    private var isDataLoaded: Bool = false
    
    //MARK: - GUI variables
    
    private lazy var convertContainerView: UIView = {
        var view = UIView()
        view.backgroundColor = .init(rgb: 0xF3F4F5)
        view.isOpaque = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var convertButton: UIButton = {
        var button = UIButton(type: .system)
        button.backgroundColor = .init(rgb: 0xEBF0ED)
        button.setTitle("Конвертировать по курсу от НБТ", for: .normal)
        button.setTitleColor(.init(rgb: 0x219653), for: .normal)
        button.layer.cornerRadius = 16
        button.tintColor = .init(rgb: 0x219653)
        button.setImage(UIImage(named: "convert"), for: .normal)
        button.imageEdgeInsets.right = 16
        button.addTarget(self, action: #selector(self.convertBarButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var tableView: UITableView = {
        var tableView = UITableView(frame: .zero, style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.estimatedRowHeight = 70
        tableView.rowHeight = 70
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.register(NBTTableViewCell.self, forCellReuseIdentifier: NBTTableViewCell.identifier)
        tableView.register(NBTTableViewFooterView.self, forHeaderFooterViewReuseIdentifier: NBTTableViewFooterView.identifier)
        tableView.register(NBTTableViewHeaderView.self, forHeaderFooterViewReuseIdentifier: NBTTableViewHeaderView.identifier)
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
        
        self.navigationItem.title = "Курсы от НБТ"
        self.view.backgroundColor = .init(rgb: 0xF3F4F5)
        self.addSubviews()
        self.makeConstraints()
        self.startLoad()
    }
    
    //MARK: - Constraints
    
    private func makeConstraints() {
        self.convertContainerView.snp.makeConstraints { (make) in
            if #available(iOS 11.0, *) {
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            } else {
                make.top.equalTo(self.topLayoutGuide.snp.bottom)
            }
            make.left.right.equalToSuperview()
        }
        self.convertButton.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(16)
            make.height.equalTo(48)
        }
        self.tableView.snp.makeConstraints { (make) in
            make.top.equalTo(self.convertContainerView.snp.bottom)
            make.left.right.bottom.equalToSuperview().inset(16)
        }
    }
    
    //MARK: - Setters
    
    private func addSubviews() {
        self.view.addSubview(self.tableView)
        self.view.addSubview(self.convertContainerView)
        self.convertContainerView.addSubview(self.convertButton)
        if #available(iOS 10.0, *) {
            self.tableView.refreshControl = self.refreshControl
        } else {
            self.tableView.addSubview(self.refreshControl)
        }
    }
    
    //MARK: - Actions
    
    @objc private func refreshControlValueChanged(_ sender: UIRefreshControl) {
        sender.beginRefreshing()
        self.startLoad()
    }
    
    @objc private func convertBarButtonTapped(_ sender: UIButton) {
        let convertController = ConvertViewController()
        let navController = UINavigationController(rootViewController: convertController)
        convertController.initWithModels(self.data)
        convertController.setupModel(image: nil)
        self.present(navController, animated: true, completion: nil)
    }
    
    //MARK: - Network
    
    private func fetchData() {
        Network.shared.request(
            url: .nbt_rates, completion: { [weak self] (response: Result<[NBTRateModel], NetworkError>) in
                guard let self = self else { return }
                var fethchedModels: [NBTRateModel]?
                switch response {
                case .success(let models):
                    fethchedModels = models
                    break
                case .failure(let error):
                    fethchedModels = try? CodableStorage.shared.fetch(for: URLPath.nbt_rates.rawValue)
                    print(error)
                    break
                }
                if let fethchedModels = fethchedModels {
                    self.data = fethchedModels
                }
                
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(1)) {
                    self.endLoading()
                }
        })
        self.refreshControl.endRefreshing()
    }
    
    //MARK: - Helpers
    
    private func startLoad() {
        guard !self.isRequestBusy else {
            self.refreshControl.endRefreshing()
            return
        }
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
        self.isRequestBusy = false
        self.isDataLoaded = true
        self.tableView.windless.end()
        self.tableView.reloadData()
        self.refreshControl.endRefreshing()
    }

}

extension NBTViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.isDataLoaded {
            return self.data.count
        }
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NBTTableViewCell.identifier, for: indexPath)
        if self.isDataLoaded {
            (cell as? NBTTableViewCell)?.initCell(model: self.data[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if self.isDataLoaded,
           indexPath.row == self.data.count - 1 {
            (cell as? NBTTableViewCell)?.separatorView.isHidden = true
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: NBTTableViewHeaderView.identifier)
        view?.setNeedsUpdateConstraints()
        return view
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: NBTTableViewFooterView.identifier)
        view?.setNeedsUpdateConstraints()
        return view
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let barHeght = self.navigationController?.navigationBar.bounds.height else { return }
        let verticalOffset = scrollView.contentOffset.y + barHeght
        if verticalOffset > barHeght {
            self.convertContainerView.transform = CGAffineTransform.identity
            self.convertContainerView.backgroundColor = .init(rgb: 0xFAFAFA)
        } else if verticalOffset == barHeght {
            self.convertContainerView.transform = CGAffineTransform.identity
            self.convertContainerView.backgroundColor = .init(rgb: 0xF3F4F5)
        } else {
            self.convertContainerView.transform = CGAffineTransform(translationX: 0, y: -scrollView.contentOffset.y)
            self.convertContainerView.backgroundColor = .init(rgb: 0xF3F4F5)
        }
    }
    
}
