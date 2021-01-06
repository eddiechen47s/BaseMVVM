//
//  SettingViewCell.swift
//  MVVM+TableView
//
//  Created by ktrade on 2021/1/6.
//

import UIKit

class SettingViewCel: UITableViewCell {
    static let identifier = "SettingViewCel"
    
    private let nameLabel: UILabel = {
        let lab = UILabel()
        return lab
    }()
    
    private let emailLabel: UILabel = {
        let lab = UILabel()
        lab.textAlignment = .left
        return lab
    }()
    
    private let typelLabel: UILabel = {
        let lab = UILabel()
        lab.textAlignment = .left
        return lab
    }()
    
    private let sizelLabel: UILabel = {
        let lab = UILabel()
        lab.textAlignment = .right
        return lab
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    func configure(vm model: AddCoffeeOrder) {
        self.nameLabel.text = model.name
        self.emailLabel.text = model.email
        self.typelLabel.text = model.type
        self.sizelLabel.text = model.size
    }
    
    private func setupUI() {
        addsubviews(nameLabel,
                    emailLabel,
                    typelLabel,
                    sizelLabel
        )
        
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(snp.centerY)
            make.left.equalTo(snp.left).offset(10)
            make.width.equalTo(snp.width).multipliedBy(0.2)
            make.height.equalTo(snp.height)
        }
        
        emailLabel.snp.makeConstraints { make in
            make.centerY.equalTo(snp.centerY)
            make.left.equalTo(nameLabel.snp.right)
            make.width.equalTo(snp.width).multipliedBy(0.4)
            make.height.equalTo(snp.height)
        }
        
        typelLabel.snp.makeConstraints { make in
            make.centerY.equalTo(snp.centerY)
            make.right.equalTo(sizelLabel.snp.left)
            make.width.equalTo(snp.width).multipliedBy(0.2)
            make.height.equalTo(snp.height)
        }
        
        sizelLabel.snp.makeConstraints { make in
            make.centerY.equalTo(snp.centerY)
            make.right.equalTo(snp.right).offset(-10)
            make.width.equalTo(snp.width).multipliedBy(0.2)
            make.height.equalTo(snp.height)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
