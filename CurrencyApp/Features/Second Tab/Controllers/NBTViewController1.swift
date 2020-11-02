//
//  NBTViewController.swift
//  CurrencyApp
//
//  Created by Humo Programmer  on 10/9/20.
//

import UIKit

class NBTViewController1: BaseViewController {
    
    //MARK: - Public variables
    
    //MARK: - Private variables
    
    private var data: [NBTRateModel] = []
    private var isRequestBusy: Bool = false
    private var isDataLoaded: Bool = false
    
    //MARK: - GUI variables
    
    private lazy var headerView: NBTHeaderView = {
        var view = NBTHeaderView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var tableView: UITableView = {
        var tableView = UITableView(frame: .zero, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.sectionHeaderHeight = 64
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.register(NBTTableViewCell1.self, forCellReuseIdentifier: NBTTableViewCell1.identifier)
        tableView.register(NBTHeaderView.self, forHeaderFooterViewReuseIdentifier: "header")
        if #available(iOS 10.0, *) {
            tableView.refreshControl = self.refreshControl
        } else {
            tableView.addSubview(self.refreshControl)
        }
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    //MARK: - Constraints
    
    private func makeConstraints() {
        self.headerView.snp.makeConstraints { (make) in
            make.width.equalTo(UIScreen.main.bounds.width - 40)
        }
        self.tableView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview().inset(20)
            make.bottom.equalToSuperview()
        }
    }
    
    //MARK: - Setters
    
    private func addSubviews() {
        self.view.addSubview(self.tableView)
    }
    
    //MARK: - Actions
    
    @objc private func refreshControlValueChanged(_ sender: UIRefreshControl) {
        sender.beginRefreshing()
        self.startLoad()
    }
    
    
    //MARK: - Network
    
    private func fetchData() {
        Network.shared.testRequest { [weak self] (response: Result<[NBTRateModel], NetworkError>) in
            guard let self = self else { return }
            switch response {
            case .success(let models):
                self.data = models
                break
            case .failure(let error):
                print(error)
                break
            }
            self.endLoading()
        }
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

extension NBTViewController1: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header")
        tableView.backgroundView?.backgroundColor = .clear
        return view
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NBTTableViewCell1.identifier, for: indexPath)

        (cell as? NBTTableViewCell1)?.initCell(model: self.data[indexPath.row])
        return cell
    }
    
}
