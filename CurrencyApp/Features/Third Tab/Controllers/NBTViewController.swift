//
//  ThirdTabViewController.swift
//  CurrencyApp
//
//  Created by Humo Programmer  on 11/2/20.
//

import UIKit

class NBTViewController: BaseViewController {
    
    //MARK: - Public variables
    
    //MARK: - Private variables
    
    private var data: [NBTRateModel] = []
    private var isRequestBusy: Bool = false
    private var isDataLoaded: Bool = false
    
    //MARK: - GUI variables

    private lazy var tableView: UITableView = {
        var tableView = UITableView(frame: .zero, style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.estimatedRowHeight = 70
        tableView.rowHeight = 70//UITableView.automaticDimension
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
        self.tableView.snp.makeConstraints { (make) in
            //make.top.left.right.equalToSuperview().inset(20)
            make.edges.equalToSuperview().inset(20)
        }
    }
    
    //MARK: - Setters
    
    private func addSubviews() {
        self.view.addSubview(self.tableView)
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
    
    //MARK: - Network
    
    private func fetchData() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(4)) {
            var result: [NBTRateModel] = []
            for i in 0...10 {
                let model = NBTRateModel(id: "\(i)" , char_code: "USD", nominal: 1, name: "Name", value: 0.5767)
                result.append(model)
            }
            self.data = result
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
    
}
