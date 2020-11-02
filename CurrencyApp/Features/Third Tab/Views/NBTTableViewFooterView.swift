//
//  NBTTableViewFooterView.swift
//  CurrencyApp
//
//  Created by Humo Programmer  on 11/2/20.
//

import UIKit

class NBTTableViewFooterView: UITableViewHeaderFooterView {
    
    static let identifier = "NBTTableViewFooterView"
    
    //MARK: - GUI variables
    
    private lazy var view1: UIView = {
        var view = UIView()
        view.layer.cornerRadius = 12
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var view2: UIView = {
        var view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK: - Initialization
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        self.addSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.addSubviews()
    }
    
    //MARK: - Constraints
    
    override func updateConstraints() {
        self.view1.snp.updateConstraints { (make) in
            make.edges.equalToSuperview()
        }
        self.view2.snp.updateConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.5)
        }
        super.updateConstraints()
    }
    
    //MARK: - Setters
    
    private func addSubviews() {
        self.contentView.addSubview(self.view1)
        self.view1.addSubview(self.view2)
    }
    
}
