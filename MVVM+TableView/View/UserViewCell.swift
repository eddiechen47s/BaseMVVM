//
//  UserViewCell.swift
//  MVVM+TableView
//
//  Created by ktrade on 2021/1/4.
//

import UIKit

class UserViewCell: UITableViewCell {
    
    static let identifier = "UserViewCell"
    
    let nameLabel: UILabel = {
        let lab = UILabel()
        return lab
    }()
    
    let genderLabel: UILabel = {
        let lab = UILabel()
        lab.textAlignment = .right
        return lab
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    func configure(vm model: User) {
        self.nameLabel.text = model.name
        self.genderLabel.text = model.gender
    }
    
    private func setupUI() {
        addsubviews(nameLabel,
                    genderLabel)
        
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(snp.centerY)
            make.left.equalTo(snp.left).offset(10)
            make.width.equalTo(snp.width).multipliedBy(0.5)
            make.height.equalTo(snp.height)
        }
        
        genderLabel.snp.makeConstraints { make in
            make.centerY.equalTo(snp.centerY)
            make.right.equalTo(snp.right).offset(-10)
            make.width.equalTo(snp.width).multipliedBy(0.5)
            make.height.equalTo(snp.height)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

