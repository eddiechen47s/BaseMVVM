//
//  User.swift
//  MVVM+TableView
//
//  Created by ktrade on 2020/12/8.
//

import Foundation

struct UserList: Codable {
    let contacts: [User]
}

struct User: Codable {
    let id: String
    let name: String
    let gender: String
}
